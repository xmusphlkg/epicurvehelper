# Epicurvehelper

## Background

### Who?

我们是厦门大学公共卫生学院的流行病学课题组，我们致力于让中国的基层疾控部门和公共卫生人员用上更加简单易用的工具，让数据分析和可视化不再有门槛，为此我们开发了一系列产品。

这些产品都是在前人工作的基础上开发的，如果您认为我们的工作帮助到了您，请您移步到[`Github`]([xmusphlkg/epicurvehelper (github.com)](https://github.com/xmusphlkg/epicurvehelper))为我们点亮一个星星，这是对我们工作最大的肯定。

如果您对于我们的产品感兴趣，欢迎关注我们的微信公众号(CTModelling)。

### Why?

[Epicurvehelper](https://github.com/xmusphlkg/epicurvehelper)起源于去年公卫人发的一个介绍流行曲线在疫情期间的作用，但是有很多评论不知道怎么画流行曲线，即使是最简单的Excel也不会，诚然录制Excel绘制流行曲线的教程会更加简单，也更容易传播，但是你猜怎么着？**我就不**。

### What?

得益于R语言的拓展性，[Epicurvehelper](https://github.com/xmusphlkg/epicurvehelper)可以帮助所有人画出令人满意的流行曲线：

1. 丰富的配色方案，与“Office”不同。
2. ggplot2主题，符合出版要求。
3. 无代码UI，得心应手。

## Method

### Tool

[Epicurvehelper](https://github.com/xmusphlkg/epicurvehelper)基于R语言搭建，docker化后托管在阿里云。

### Progress

1. 数据上传和修改：[DT](https://github.com/rstudio/DT)
2. 数据筛选：[datamods](https://github.com/dreamRs/datamods)
3. 颜色设置和文字修改：[esquisse](https://github.com/dreamRs/esquisse)
4. 图片导出：[esquisse](https://github.com/dreamRs/esquisse)
5. 绘图工具：[ggplot2](https://github.com/tidyverse/ggplot2)

是的，正如您所见，所有的代码都是基于前人的工作基础上的，换句话说：**我就是个裁缝**，我把前人的工作综合下，形成一个解决新问题的方案。

## Results

[Epicurvehelper](https://github.com/xmusphlkg/epicurvehelper)

## License

GNU General Public License v3.0
