# __cdx__

![logo](./logo.png)

cdx is hyper cd command.

## __Description__

cdx is wrapper for cd command. cdx can move to directory from history or bookmark, or ssh remote. 

## __Install__

```sh
git clone https://github.com/xztaityozx/cdx
cd cdx
./install.sh
```

## __Usage__

```sh
cdx [OPTION] PATH
```

Usage is the same the cd command.

### __Options__

|Option|Action|
|:--:|:--:|
|--help|Show help|
|--fuzzy|Use fuzzy search like fzf , peco or etc. The command name must be stored in the variable `CDX_FUZZY_COMMAND`|
|--cd|Use cd command instead of pushd|
|--ls|ls command automatically executes after change directory|
|-h|cd from history. This option require --fuzzy option|
|-b|cd from bookmark. This option require --fuzzy option|
|+b|Add current directory to bookmark|
|-p|Use popd command instead of cd or pushd command|
|--automake|When destination directory is not exists. cdx make directory automatically|
|--make|When destination directory is not exists. cdx asks if you want to make directory|
|--ssh|Allow ssh login when giving cdx a host name in `~/.ssh/config`. If same name directory exists. change directory has priority.|

If you always add options, write options to `CDX_DEFAULT_OPTS`. cdx automatically adds  options.

ex)  
`~/.bashrc`

```sh
...
CDX_DEFAULT_OPTS="--ssh --fuzzy --make"
CDX_FUZZY_COMMAND="fzf"
...
```

# __cdx__

`cdx` は ハイパーな`cd`コマンドです

## __Description__

`cdx`はcdコマンドのラッパースクリプトです。履歴やブックマーク、sshリモートへ移動できます。

## __Install__

```sh
git clone https://github.com/xztaityozx/cdx
cd cdx
./install.sh
```

## __Usage__

```sh
cdx [OPTION] PATH
```

使い方はcdコマンドと同じです。

### __Options__

|Option|Action|
|:--:|:--:|
|--help|ヘルプを表示します|
|--fuzzy|パスの補完や履歴、ブックマークの取得に`fzf`や`peco`のようなファジー検索ツールを使用します|
|--cd|`cdx`ではデフォルトで`pushd`コマンドを使うようにしていますがこれを`cd`に置き換えます|
|--ls|`cd`した後に自動的に`ls`コマンドを実行します|
|-h|履歴から`cd`します。これには--fuzzyオプションが必要です|
|-b|ブックマークから`cd`します。これには--fuzzyオプションが必要です|
|+b|カレントディレクトリをブックマークに追加します|
|-p|`cd`や`pushd`の代わりに`popd`を実行します|
|--automake|移動先が見つからなかったとき自動的にディレクトリを作り`cd`します|
|--make|移動先が見つからなかったときにディレクトリを作ってもいいか尋ねます|
|--ssh|`cdx`に`ssh`を許可します。これをオンにして`~/.ssh/config`にあるホスト名を与えると`ssh`ログインを試みます。もし同じ名前のディレクトリがある場合は`cd`が優先されます|

設定は`~/.bashrc`にでも書くといいと思います。

```sh
...
CDX_DEFAULT_OPTS="--ssh --make --fuzzy"
CDX_FUZZY_COMMAND="fzf"
...
```
