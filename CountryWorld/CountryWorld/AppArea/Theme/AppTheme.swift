//
//  AppTheme.swift
//  CountryWorld
//
//  Created by Gabriele Moia on 18/02/23.
//

import Foundation

class AppTheme {
    
    public func applyTheme() {
        self.applyViewsTheme()
        self.applyLabels()
    }
    
    private func applyViewsTheme() {
        CountrySectionHeaderView.appearance().themeBackgroundColor = Color.lightGrey.uiColor
        CountrySectionHeaderView.appearance().themed = true
        
        CountryTableViewCell.appearance().themeTitleColor = .black
        CountryTableViewCell.appearance().themeTitleFont = Font.SFUITextBold17
        CountryTableViewCell.appearance().themeSubtitleColor = Color.darkGrey.uiColor
        CountryTableViewCell.appearance().themeSubtitleFont = Font.SFUITextBold15
        
        BaseViewControllerTheme.appearance().themeStartGradientColor = Color.themeStartGradientBackgroundColor.uiColor
        BaseViewControllerTheme.appearance().themeEndGradientColor = Color.themeEndGradientBackgroundColor.uiColor
        
        DetailItemView.appearance().themeDividerColor = Color.darkGrey.uiColor
        DetailItemView.appearance().themed = true
    }
    
    private func applyLabels() {
        DarkGreySFUITextBold17Label.appearance().font = Font.SFUITextBold17
        DarkGreySFUITextBold17Label.appearance().textColor = Color.darkGrey.uiColor
        
        DarkGreySFUITextBold15Label.appearance().font = Font.SFUITextBold15
        DarkGreySFUITextBold15Label.appearance().textColor = Color.darkGrey.uiColor
        
        WhiteSFUITextBold15Label.appearance().font = Font.SFUITextBold15
        WhiteSFUITextBold15Label.appearance().textColor = .white
        
        BlackSFUITextBold17Label.appearance().font = Font.SFUITextBold17
        BlackSFUITextBold17Label.appearance().textColor = .black
        
        WhiteSFUITextBold17Label.appearance().font = Font.SFUITextBold17
        WhiteSFUITextBold17Label.appearance().textColor = .white
        
        WhiteBlankScriptBold17Label.appearance().font = Font.BlankScriptBold17
        WhiteBlankScriptBold17Label.appearance().textColor = Color.lightGrey.uiColor
    }
}
