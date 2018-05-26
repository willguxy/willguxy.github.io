---
layout: article
title: Mac/Ubuntu下终端色彩主题设置
comment: true
key: 20171216
tags: idea tip
---

审美是主观的, 但是总有一些东西是大家普遍觉得更"美"的. 我自己由于工作性质和个人爱好两方面的原因, 平时大部分时间都是对着Mac或者Ubuntu下的Terminal做事情. 从最基本的bash脚本, 到工作上用到的R, Python等等, 都离不开终端窗口和Vim. 甚至我的个人博客, 都是建立在github上的, 所有的markdown格式我都使用Vim编辑. 既然每天对着的东西, 肯定希望有一个漂亮的界面, 让自己身心愉悦.

所以这篇博客, 就总结一下自己长期以来为了让界面更漂亮, 而使用的一些设置技巧和工具.

首先抛弃了Ubuntu和Mac下的默认Terminal, 而更换为Terminator(Ubuntu)或者iTerm2(Mac). 其中Terminator可以直接通过apt安装. 从版本上来说我用的是0.98版, 已经很久没有更新过了. 看到有人folk了前面的版本并且在做更新, 但还没有加入到Ubuntu的默认ppa列表里. 暂时0.98也够用了, 在Ubuntu 16.04的系统下还没出现过什么大问题. 而iTerm2只需要搜索一下就能找到下载安装的方法.

后面的步骤两个不同的系统就可以基本通用了. 下载好之后需要把默认的bash换成zsh, 而且最好是[oh-my-zsh][oh-my-zsh]. 如果担心zsh和bash之间的区别, 可以网上查一下可能的caveat. 对我个人的工作来说, 还没有发现明显的不同. 安装好以后, 可以在`$HOME/.zshrc`文件里改动主题设置和插件等等. 同时检查一下自己的`$PATH`是不是还正确, 以及设置的各种alias等等. 我Mac下选择的主题是`ys`, 而Ubuntu下是`agnoster`. 两个在我看来都很好. `agnoster`显示的稍微紧凑一点, 因为行数更少.

接下来就需要改变色彩主题了. 我们克隆[iterm2-color-theme]这个github repo. 里面对于iTerm2和Terminator都有分别的设置. 按照github repo的说明文档, iTerm2可以在`设置`->`Profiles`->`Color`里选择`Color Presets`, 然后导入你想要的`.itermcolors`文件. Terminator更加简单, 只需要复制你喜欢的主题对应的`.confg`文件里的代码, 然后放在你Terminator的设置文件里即可. 这里记得同事改变layout设置下的默认主题. 两个系统下我都选择了Dracula(德古拉)这个深色的主题. 这里面还有很多选择, 建议大家多做尝试.

字体的选择也很重要. Ubuntu下默认的Mono字体就很不错了, 但我还是选择了用[Powerline][powerline]系列的字体, 字符的过渡部分更加圆滑. 大家可以遵照github repo里面的说明, 安装即可. 字体安装好之后, 在终端设置里找Powerline系列的字体. 我自己选了DejaVu Sans Mono for Powerline. 

最后Vim的色彩主题选择, 只需要克隆[badwolf][badwolf]这个repo到本地, 然后把colors目录下的`.vim`文件放到`$HOME/.vim/colors/`目录下就可以了. 也可以创建symbolic link, 这样repo有更新的话, 你的vim主题也能得到更新. 最后一步在`$HOME/.vimrc`文件里加入或者修改`colorscheme badwolf`或者`colorscheme goodwolf`. 其中badwolf是深色主题, goodwolf是浅色主题


[iterm2-color-theme]: https://github.com/mbadolato/iTerm2-Color-Schemes
[badwolf]: https://github.com/sjl/badwolf
[oh-my-zsh]: https://github.com/robbyrussell/oh-my-zsh
[powerline]: https://github.com/powerline/fonts

