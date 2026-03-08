# Windows11 setup

Install List

- Visual Studio Code
- Google Chrome
- Slack
- Docker Desktop for Windows
- DBeaver
- Postman
- Git for Windows
- Line

scoop list

```
scoop bucket add extras
```

```
scoop list
Installed apps:

Name           Version      Source Updated             Info
----           -------      ------ -------             ----
7zip           23.01        main   2024-01-25 15:50:38
aqua           2.22.0       main   2024-01-31 17:39:33
autohotkey     2.0.11       extras 2024-01-26 17:12:11
curl           8.5.0_6      main   2024-01-25 15:55:00
fzf            0.46.0       main   2024-01-25 17:36:47
ghq            1.4.2        main   2024-01-25 17:53:41
go             1.21.6       main   2024-01-25 15:55:55
grep           3.11         main   2024-01-26 16:19:48
grpcurl        1.8.9        main   2024-03-01 22:25:13
helm           3.14.0       main   2024-01-25 17:37:49
helmfile       0.161.0      main   2024-01-31 17:42:03
hub            2.14.2       main   2024-01-31 16:23:32
innounp        0.50         main   2024-01-31 17:42:11
jq             1.7.1        main   2024-01-25 17:38:39
kubectl        1.29.1       main   2024-01-25 17:38:06
kubectx        0.9.5        main   2024-01-25 17:38:48
kubens         0.9.5        main   2024-01-26 16:14:28
lua            5.4.2        main   2024-01-31 20:04:01
msys2          2024-05-07   main   2024-06-27 17:08:07
mysql          8.3.0        main   2024-01-25 17:39:21
openssl        3.2.0        main   2024-01-31 17:47:39
peco           0.5.11       main   2024-01-25 18:03:57
protobuf       25.3         extras 2024-03-01 21:46:35
redis          7.0.15       main   2024-01-31 17:49:25
ruby           3.3.3-1      main   2024-06-27 17:03:08
skaffold       2.10.0       extras 2024-01-25 17:40:52
sqlite         3.45.0       main   2024-01-27 17:00:55
terminal-icons 0.11.0       extras 2024-02-01 16:13:07
touch          0.2018.07.25 main   2024-01-25 16:26:53
which          2.20         main   2024-01-25 15:56:37
yarn           1.22.19      main   2024-01-26 22:07:47
z              1.1.13       extras 2024-02-01 12:45:29
```

PowerShell

設定ファイルの場所

notepad $PROFILE

```
. $env:USERPROFILE\.config\powershell\user_profile.ps1
```

oh-my-posh

```
フォントのインストール
oh-my-posh font install
テーマ一覧を表示
Get-PoshThemes
```

### Node.js

https://learn.microsoft.com/ja-jp/windows/dev-environment/javascript/nodejs-on-windows

### dotfile のシンボリックリンク登録

管理者権限で PowerShell を起動して実行

```powershell
New-Item -ItemType SymbolicLink -Path C:\Users\genta\.config -Target C:\Users\genta\repositories\dotfiles\.config
New-Item -ItemType SymbolicLink -Path C:\Users\genta\AppData\Local\nvim -Target C:\Users\genta\repositories\dotfiles\.config\nvim
New-Item -ItemType SymbolicLink -Path C:\Users\genta\.gitconfig -Target C:\Users\genta\repositories\dotfiles\.gitconfig
New-Item -ItemType SymbolicLink -Path C:\Users\genta\.bashrc -Target C:\Users\genta\repositories\dotfiles\.bashrc
```
