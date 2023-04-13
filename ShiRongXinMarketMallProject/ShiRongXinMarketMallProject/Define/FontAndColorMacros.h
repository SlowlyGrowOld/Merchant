//
//  FontAndColorMacros.h
//  SeaStarVoice
//
//  Created by 薛静鹏 on 2019/9/10.
//  Copyright © 2019 薛静鹏. All rights reserved.
//

//字体大小和颜色配置

#ifndef FontAndColorMacros_h
#define FontAndColorMacros_h

#pragma mark -  间距区
//默认间距
#define KNormalSpace 12.0f

#pragma mark -  颜色区
//主题色 导航栏颜色
#define CNavBgColor  [UIColor colorWithHexString:@"ffffff"]
//#define CNavBgColor  [Ulor colorWithHexString:@"ffffff"]
#define CNavBgFontColor  [UIColor colorWithRed:0/255.0 green:0/255.0 blue:0/255.0 alpha:1.0]
#define MainColor [UIColor colorWithRed:221/255.0 green:162/255.0 blue:57/255.0 alpha:1.0]
//默认页面背景色
#define CViewBgColor [UIColor colorWithHexString:@"F5F5F5"]
//默认选中颜色
#define CViewSelectBgColor [UIColor colorWithHexString:@"DDA33B"]
//分割线颜色
#define CLineColor [UIColor colorWithHexString:@"EEEEEE"]

//Cell未选中背景颜色
#define CellBGColor [UIColor colorWithHexString:@"EFEFEF"]
//字色
#define CFontColor [UIColor colorWithHexString:@"DDA239"]
//次级字色
#define CFontColor1 [UIColor colorWithHexString:@"1f1f1f"]

//再次级字色
#define CFontColor2 [UIColor colorWithHexString:@"5c5c5c"]

//无效的字色
#define CFontUnselected [UIColor colorWithHexString:@"A0A0A0"]

//红色
#define CRed [UIColor colorWithHexString:@"DF0000"]

//橘红色
#define COrange [UIColor colorWithHexString:@"C84D1D"]
//再次级字色
#define CFont99 [UIColor colorWithHexString:@"999999"]
//次级字色
#define CFont66 [UIColor colorWithHexString:@"666666"]
//字色
#define CFont3D [UIColor colorWithHexString:@"3D3D3D"]
//字色
#define CFont05 [UIColor colorWithHexString:@"050505"]

#pragma mark -  字体区
#define PFR20Font [UIFont fontWithName:PFR size:20]
#define PFR18Font [UIFont fontWithName:PFR size:18]
#define PFR16Font [UIFont fontWithName:PFR size:16]
#define PFR15Font [UIFont fontWithName:PFR size:15]
#define PFR14Font [UIFont fontWithName:PFR size:14]
#define PFR13Font [UIFont fontWithName:PFR size:13]
#define PFR12Font [UIFont fontWithName:PFR size:12]
#define PFR11Font [UIFont fontWithName:PFR size:11]
#define PFR10Font [UIFont fontWithName:PFR size:10]
#define PFR9Font [UIFont fontWithName:PFR size:9]
#define PFR8Font [UIFont fontWithName:PFR size:8]
#define PFRFontMediumSize(size) [UIFont systemFontOfSize:kRealValue(size) weight:UIFontWeightMedium]
#define PFRFontSize(size)  [UIFont systemFontOfSize:kRealValue(size)]
#endif /* FontAndColorMacros_h */
