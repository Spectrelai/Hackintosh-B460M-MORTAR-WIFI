# OpenCore EFI For B460M-MORTAR-WIFI

当前OC版本：`0.7.8`

基于[OpenCore Install Guide](https://dortania.github.io/OpenCore-Install-Guide/)，采用最简配置

## 适配说明

#### config.rx6600xt.plist

- macOS: 12.1以上
- CPU：Intel Core i 10th，未测试ES版CPU
- GPU: AMD RX6600XT，理论支持受macOS支持的RX5000系和RX6000系显卡

#### config.uhd630.plist

- macOS: 12.0以上
- CPU：Intel Core i 10th，未测试ES版CPU
- GPU: Intel UHD630

## 功能验证

| 功能 | 测试结果         | 备注                                                         |
| ---- | ---------------- | ------------------------------------------------------------ |
| CPU  | 变频正常         |                                                              |
| 核显 | UHD630功能正常   | 性能释放正常                                                 |
| 独显 | RX6600XT功能正常 | RX6000系加载苹果logo时会有几率显示黑屏，但加载完后可正常进入系统，目前暂无解决方式 |
| 睡眠 | 正常             | 如遇关机后自动开机问题需要在Bios设置中关闭usb唤醒            |
| WIFI | 正常             |                                                              |
| 蓝牙 | 正常             | Airdrop不可用，为Intel第三方驱动限制，如需求此功能需要更换mac免驱网卡 |
| 网口 | 正常             | 支持2.5G速率                                                 |
| USB  | 正常             | USB已定制，前面板USB3.0 * 2 + Type C * 1， 后面板USB2.0 * 2 + USB3.0 * 1（ Type C旁） + Type C * 1， 阉割了两个后面板USB 3.0 |

## 使用说明

**请勿直接使用**

1. 根据使用的显卡选择`config.uhd630.plist`或`config.rx6600xt.plist`,改名为`config.plist`

2. 参考[OpenCore Install Guide](https://dortania.github.io/OpenCore-Install-Guide/config.plist/comet-lake.html#platforminfo)或其他方式配置`config.plist`三码，i7及以下使用iMac20,1机型，i9使用iMac20,2机型

3. Bios设置打开`D.T.M`，该设置为微星自带黑苹果一键设置，打开后不需要再修改其他项，如需要win11启动可以再打开PTT

4. OC在0.7.5后增加了ResizeGpuBars和ResizeAppleGpuBars适配了主板的ResizeBar设定, 经测试开启后会导致macOS睡眠唤醒黑屏，未找到解决方案所以都设定为了-1，同时主板的ResizeBar需要关闭，否则无法引导macOS。有需求的可以自行研究解决

## 注意事项

- 不适用非Wifi版迫击炮，如需使用需要删除网卡和蓝牙相关kexts，并修改`config.plist`中声卡的pci地址
- 三码需要保证唯一性，否则可能会影响Handoff，iMessage和FaceTime功能

## 硬件测试配置

| 部件     | 型号                     |
| -------- | ------------------------ |
| CPU      | Intel Core i7-10700           |
| 主板     | 微星 B460M MORTAR WIFI   |
| 内存     | 英睿达 DDR4 3200 8GB × 4 |
| 核显     | Intel UHD630            |
| 独显     | 蓝宝石 RX6600XT 超白金    |
| 有线网卡 | RTL8125（板载）          |
| 无线网卡 | Intel AX200（板载）      |
| 硬盘     | 西数SN750 500G（macOS） 闪迪 至尊高速 m.2 1TB（Windows）    |

## 定制参考说明

### USB定制

如果现有的USB定制不符合你的机箱接口情况，可以重新定制USB端口

USB定制程序：[USBMap](https://github.com/corpnewt/USBMap)

参考链接内README中的Quick Start进行使用，可以在本EFI的`USBMap.kexts`基础上加载进行修改

特殊端口说明：

- HS08：蓝牙使用，必须包含，否则蓝牙失效
- HS11：内部USB2.0Hub使用，必须包含
- HS12：微星灯效使用，mac下没有适配，可屏蔽

生成新的`USBMap.kexts`后替换原本的`USBMap.kexts`