# Hackintosh-B460M-MORTAR-WIFI

EFI大部分基于[OpenCore Install Guide](https://dortania.github.io/OpenCore-Install-Guide/)，采用最简配置

## 当前版本

`OC`:0.7.5

`macOS`:12.0.1

## 功能说明

- CPU变频正常
- Wifi，蓝牙正常
- 睡眠唤醒正常
- 核显性能释放正常
- Airdrop不可用，为Intel第三方驱动限制，如需求此功能需要更换Mac免驱网卡
- USB已定制，前面板USB3.0 * 2 + Type C * 1， 后面板USB2.0 * 2 + USB3.0 * 1 + Type C * 1， 阉割了两个后面板USB 3.0

## 使用说明

**请勿直接使用**

1. 根据使用的显卡选择`config.uhd630.plist`或`config.rx5500xt.plist`,改名为`config.plist`

2. 参考[OpenCore Install Guide](https://dortania.github.io/OpenCore-Install-Guide/config.plist/comet-lake.html#platforminfo)或其他方式配置`config.plist`三码，i7及以下使用iMac20,1机型，i9使用iMac20,2机型

3. Bios设置打开`D.T.M`

## 注意事项

- 不适用非Wifi版迫击炮，如需使用需要删除网卡和蓝牙相关kexts，并修改`config.plist`中声卡的pci地址

- 如遇关机后自动开机问题需要在Bios设置中关闭usb唤醒

## 硬件测试配置

| 部件     | 型号                     |
| -------- | ------------------------ |
| CPU      | Intel i5-10400           |
| 主板     | 微星 B460M MORTAR WIFI   |
| 内存     | 英睿达 DDR4 3200 8GB × 4 |
| 核显     | Intel UHD630            |
| 独显     | 蓝宝石 RX5500XT          |
| 有线网卡 | RTL8125（板载）          |
| 无线网卡 | Intel AX200（板载）      |
| 硬盘     | 闪迪 至尊高速 m.2 1TB    |
