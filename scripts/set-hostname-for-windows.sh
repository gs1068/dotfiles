#!/bin/bash

# このスクリプトは awscli、jq、および sed を必要とします。
# brew install awscli jq sed

(
  # 実行中のEC2の一覧を取得し、BEインスタンスの名前とインスタンスIDを抽出
  ec2=$(
    aws ec2 describe-instances |
      jq -c '[.Reservations[] | .Instances[] | select(.State.Name == "running") | {name: (.Tags[] | select({Key: "Name"})).Value, InstanceId: .InstanceId}  | select(contains({name: "circus_agent"})) | select(contains({name: "-backend-ASG"}))]'
  )

  function replace() {
    local env="${1}"
    local ec2_key=''
    # 他に環境増えたらこれも増やす.増えすぎたら連想配列にする
    if [ "$env" = 'production' ]; then
      ec2_key='prd'
    elif [ "$env" = 'development' ]; then
      ec2_key='qa'
    elif [ "$env" = 'development1' ]; then
      ec2_key='dev1'
    fi

    # インスタンスIDの取得
    local instance_id=$(echo $ec2 | jq -r "[.[] | select(contains({name: \"${ec2_key}\"}))] | .[0] | .InstanceId")

    # 書き換え
    # Windowsの場合は`gsed`を`sed`に書き換え(Git BashやWSL2に入ってるのがGNU sedなはずなので)
    sed -i -E -z "s/(Host circus-$env\n[[:space:]]+HostName[[:space:]]+)i-[[:alnum:]]+/\\1$instance_id/" ~/.ssh/config
  }

  # 他に環境増えたらこれも増やす
  replace production
  replace development
  replace development1
)
