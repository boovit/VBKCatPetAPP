//
//  YHDesignMacro.h
//  CatPetAPP
//
//  Created by weibo02 on 2018/5/17.
//  Copyright © 2018年 yaohr. All rights reserved.
//

#ifndef YHDesignMacro_h
#define YHDesignMacro_h

//color
#define YHDesignMacroColor_Theme (0xff6e97)  //主题颜色
#define YHDesignMacroColor_Deputy_Dark (0x1a2d27) //深副色，与主题色形成反差色，用于文字，未选中图标等
#define YHDesignMacroColor_Deputy_Light (0xffffff) //浅副色
#define YHDesignMacroColor_Background (0xffffff) //背景色 一般为白色
#define YHDesignMacroColor_Gray (0x959595) //灰色 未选择颜色
#define YHDesignMacroColor_Warning (0xff3030) //警示红
#define YHDesignMacroColor_Mask [UIColor colorWithWhite:0.0 alpha:0.2]

#define YHDesignMacroColor_Nav YHDesignMacroColor_Theme //导航栏颜色
#define YHDesignMacroColor_NavTitle YHDesignMacroColor_Deputy_Light //导航栏标题
#define YHDesignMacroColor_Tab YHDesignMacroColor_Background //Tabbar
#define YHDesignMacroColor_TabItemTitle_Normal YHDesignMacroColor_Gray //tabbar item
#define YHDesignMacroColor_TabItemTitle_Selected YHDesignMacroColor_Theme
#define YHDesignMacroColor_PlaceholderText YHDesignMacroColor_Gray  //占位文字颜色
#define YHDesignMacroColor_Shadow YHDesignMacroColor_Mask //阴影遮罩颜色
#define YHDesignMacroColor_Title YHDesignMacroColor_Deputy_Dark //一级标题色
#define YHDesignMacroColor_SubTitle YHDesignMacroColor_Deputy_Dark //二级标题色
#define YHDesignMacroColor_ThreeTitle YHDesignMacroColor_Deputy_Dark //三级标题色
#define YHDesignMacroColor_ContentText YHDesignMacroColor_Deputy_Dark //文章内容文字色


//Font size
#define YHDesignMacroFontSize_NavTitle          (20.0f)  //导航栏标题字号
#define YHDesignMacroFontSize_TabItem_Nor       (12.0f)  //tab normal
#define YHDesignMacroFontSize_TabItem_sel       (12.0f)  //tab selected
#define YHDesignMacroFontSize_Title             (18.0f)  //一级标题
#define YHDesignMacroFontSize_SubTitle          (14.0f)  //二级标题
#define YHDesignMacroFontSize_ThreeTitle        (10.0f)  //三级标题


#endif /* YHDesignMacro_h */
