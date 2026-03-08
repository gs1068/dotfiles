#!/bin/zsh
# This script requires awscli, jq, and gnu-sed.
# brew install awscli jq gnu-sed.

export AWS_PROFILE=circus
(
  # 実行中のEC2の一覧を取得し、BEインスタンスの名前とインスタンスIDを抽出
  ec2=$(
    aws ec2 describe-instances |
      jq -c '[.Reservations[] | .Instances[] | select(.State.Name == "running") | {name: (.Tags[] | select({Key: "Name"})).Value, InstanceId: .InstanceId} | select(contains({name: "circus_agent"})) | select(contains({name: "-backend-ASG"}))]'
  )

  function replace() {
    local env="${1}"
    local ec2_key=''
    # 他に環境増えたらこれも増やす.増えすぎたら連想配列にする
    # 多分dev1も追加する必要ありそう
    if [ "$env" = 'production' ]; then
      ec2_key='prd'
    elif [ "$env" = 'development' ]; then
      ec2_key='qa'
    elif [ "$env" = 'stg' ]; then
      ec2_key='stg'
    elif [ "$env" = 'dev1' ]; then
      ec2_key='dev1'
    elif [ "$env" = 'dev2' ]; then
      ec2_key='dev2'
    fi

    # インスタンスIDの取得
    local instance_id=$(echo $ec2 | jq -r "[.[] | select(contains({name: \"${ec2_key}\"}))] | .[0] | .InstanceId")
    # 書き換え
    # Windowsの場合は`gsed`を`sed`に書き換え(Git BashやWSL2に入ってるのがGNU sedなはずなので)
    gsed -i -E -z "s/(Host circus-$env\n[[:space:]]+HostName[[:space:]]+)i-[[:alnum:]]+/\\1$instance_id/" ~/.ssh/config
  }

  # 他に環境増えたらこれも増やす
  replace production
  replace stg
  replace development
  replace dev1
  replace dev2
)
