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
| CPU  | 正常            | 超线程和变频正常                                               |
| 核显 | 正常           | 性能释放正常                                                 |
| 独显 | 正常           | RX6000系一些卡加载苹果logo时会显示黑屏，加载完后可正常进入系统，目前暂无解决方式 |
| 睡眠 | 正常             | 如遇关机后自动开机问题需要在Bios设置中关闭usb唤醒（USB唤醒待优化）            |
| WIFI | 正常             |                                                              |
| 蓝牙 | 正常             | Airdrop不可用，为Intel第三方驱动限制，如需求此功能需要更换mac免驱网卡 |
| 网口 | 正常             | 支持2.5G速率                                                 |
| USB  | 正常             | USB已定制，定制情况详见[USB定制](#USB定制) |

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

定制端口表

| 名称 | 类型             | 位置                      |
| ---- | ---------------- | ------------------------- |
| HS01 | USB2.0           | 后置面板网口旁USB-A口 #1  |
| HS02 | USB2.0           | 后置面板网口旁USB-A口 #2  |
| HS03 | USB2.0           | 后置面板USB-C口旁USB-A口  |
| HS04 | USB2.0 Type-C    | 后置面板USB-C口           |
| HS05 | USB2.0           | 主板扩展口JUSB3 #1        |
| HS06 | USB2.0           | 主板扩展口JUSB3 #2        |
| HS07 | USB2.0 Type-C    | 主板扩展口JUSB4           |
| HS08 | 内置蓝牙         | 主板内置                  |
| HS09 | USB2.0           | 后置面板PS2口旁USB-A口 #1 |
| HS10 | USB2.0           | 后置面板PS2口旁USB-A口 #2 |
| HS11 | 内置USB2.0Hub    | 主板扩展口JUSB1-2         |
| HS12 | 内置微星灯效控制 | 主板内置                  |
| SS01 | USB3.0           | 后置面板网口旁USB-A口 #1  |
| SS02 | USB3.0           | 后置面板网口旁USB-A口 #2  |
| SS03 | USB3.0           | 后置面板USB-C口旁USB-A口  |
| SS04 | USB3.0 Type-C    | 后置面板USB-C口           |
| SS05 | USB3.0           | 主板扩展口JUSB3 #1        |
| SS06 | USB3.0           | 主板扩展口JUSB3 #2        |
| SS07 | USB3.0 Type-C    | 主板扩展口JUSB4           |

特殊端口说明：

- HS08：蓝牙端口，必须包含，否则蓝牙失效
- HS11：内部USB2.0Hub端口，如果未使用JUSB1-2扩展口则可以屏蔽
- HS12：微星灯效端口，mac下没有适配，可屏蔽

默认屏蔽：HS11, HS12, SS01, SS02

如果默认的USB定制不符合你的接口使用情况，可根据此表重新定制USB端口，预置的USBMap.kext包含该表所有端口，在此基础上可以去除检测端口的步骤直接进行定制选择

#### 定制步骤

1. 根据说明下载定制程序：[USBMap](https://github.com/corpnewt/USBMap)

2. 如果没有Python环境，先下载安装[Python](https://www.python.org/downloads/)

3. 运行USBMapInjectorEdit.command(macOS)或USBMapInjectorEdit.bat(Windows)

4. 拖入EFI内的USBMap.kext

5. 根据程序说明选择你需要的端口，因macOS限制，所选端口数不能超过15个

6. 修改完成后退出程序，此时原USBMap.kext已完成修改
