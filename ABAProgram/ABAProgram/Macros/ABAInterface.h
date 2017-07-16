//
//  ABAInterface.h
//  ABAProgram
//
//  Created by 张宇轩 on 2017/6/20.
//  Copyright © 2017年 宇轩. All rights reserved.
//

#ifndef ABAInterface_h
#define ABAInterface_h

#pragma mark - 只存放 项目 接口url 宏


// 账户密码登录(手机号登录)
#define ABA_IPHONE_LOGIN_URL @"/user/userLoginForPassword"

// 判断是否绑定手机号
#define ABA_BANDING_PHONE_URL @"/user/checkUserForOpenId"

// 注册并登录(第三方登录)
#define ABA_OTHER_LOGIN_URL @"/user/userRegister"

// 注册获取验证码
#define ABA_GET_VERIFICATION_CODE_URL @"/user/getRandomCodeForRegist"

// 更新用户密码--注册功能
#define ABA_UPDATE_USER_PASSWORD_URL @"/user/registUserForNew"

// 忘记密码的获取验证码接口
#define ABA_GET_VERCODE_FORGET_PASSWORD_URL @"/user/getRandomCodeForUpdate"

// 忘记密码的修改密码接口
#define ABA_MODIFY_PASSWORD_URL @"/user/updateUserPassword"

// 我的视频
#define ABA_MY_VIDEO_URL @"/userVideo/queryUserVideoByUserId"

// 历史观看
#define ABA_HISTORY_WATCH_URL @"/userVideo/queryUserHistoryLookByUserId"
// 观看记录
#define ABA_Watch_Record_URL @"/userPayRecord/queryUserPayRecordByUserId";

// 信息反馈
#define ABA_FEED_BACK_URL @"/user/insertUserFeedBackInfo"

// 用户信息编辑
#define ABA_USER_INFO_EDIT_URL @"/user/updateUserInfo"

// 获取用户信息
#define ABA_GET_USER_INFO_URL @"/user/queryUserInfo"

// 获取系统版本号
#define ABA_GET_SYSTEM_VERSION_URL @"/open/syscenter/getVertion/v1"

// 宝宝优选，优教和优班的列表
#define ABA_BABY_GOOD_CLASS_URL @"/userInstitution/queryUserInstitutionAllList"

// 亲子学堂，达人列表
#define ABA_DA_REN_LIST_URL @"/userDaRen/queryUserDaRenAllList"

// 达人条目点击后的详情列表
#define ABA_DA_REN_INFO_URL @"/userDaRen/queryUserDaRenArticleList"

// 宝宝优选详细介绍
#define ABA_BABY_DETAIL_INTRODUCTION_URL @"userInstitution/queryUserInstitutionInfo"

// 宝宝优选详情列表
#define ABA_BABY_DETAIL_URL @"/userVideo/queryUserVideoByInstitutionId"

// 亲子学堂 文章列表
#define ABA_ARTICLE_LIST_URL @"/userArticle/queryUserArticleAllList"

// 亲子学堂 文章列的图片路径

// 亲子学堂 专家列表
#define ABA_EXPORT_LIST_URL @"/userAlbum/queryUserAlbumAllList"

// 亲子学堂 专家视频的详情列表
#define ABA_EXPERT_VIDEO_INFO_LIST_URL @"/userVideo/queryUserVideoListByAlbum"

// 更新App接口 获取最新版本
#define ABA_GET_NEW_VERSION_URL @"/user/getNewVersonForAppName"

// 商品图片前缀

// 一天一播中的 活动列表接口
#define ABA_ACTIVITY_LIST_URL @"/userActivity/queryUserActivityAllList"

// 一天一播中的 正在直播
#define ABA_NOW_LIVE_URL @"/userLive/queryUserLiveForNow"

// 一天一播中的 直播回放
#define ABA_LIVE_PLAY_BACK_URL @"/userLive/queryUserLiveForHistory"

// 一天一播中的 添加留言
#define ABA_ADD_REPLY_URL @"/userLive/replyUserLiveMsgById"

// 获取留言
#define ABA_GET_REPLY_URL @"/userLive/queryUserLiveMsgForType"

// 顶一下
#define ABA_TO_ZAN_URL @"/userLive/updateUserLiveMsgTopNum"

// 更新用户观看数
#define ABA_Brow_Number_URL @"userLive/updateUserLiveLookNumById"

// 今日抢购
#define ABA_TODAY_GRAY_BUY_URL @"/userPre/queryPreGoodsForNow"

// 今日抢购详情
#define ABA_TODAY_GRAY_BUY_INFO_URL @"/userPre/queryPreGoodsForNowById"

// 查询用户收货地址
#define ABA_CHECK_USER_RECEIPT_DES_URL @"/userPre/queryUserShipByUserId"
 
// 更新用户收货地址
#define ABA_UPDATE_RECEIPT_DES_URL @"/userPre/updateUserShipInfo"

// 微信支付
#define ABA_WX_PAY_URL @"/chooseWXPay/gopay"

// 支付宝
#define ABA_ZFB_PAY_URL @"/alipay/getAlipayInfo"

// 图片
#define ABA_IMAGE @"http://yccitaba002.oss-cn-hangzhou.aliyuncs.com/Act-Snapshot/"

// HTML
#define ABA_HTML @"http://www.abashow.com"

#endif /* ABAInterface_h */
