//
//  APIDefine.h
//  FoodDelivery
//
//  Created by Thanh Tran Van on 9/15/15.
//  Copyright (c) 2015 ThanhTV. All rights reserved.
//

#ifndef FoodDelivery_APIDefine_h
#define FoodDelivery_APIDefine_h

//Base URL
#define URL_Server @"http://202.78.227.93:8025/"
//#define URL_Server @"http://192.168.1.123:7042/"

//API URL
#define API_URL_RegisterAccount @"api/registerAPI/DoRegister"
#define API_URL_Login @"api/loginAPI/DoLogin"
#define API_URL_FriendList @"api/FriendListAPI/GetFriends"
#define API_URL_StoreList @"api/StoreAPI/GetStores"
#define API_URL_CreateMeetting @"api/MeetingCreateAPI/CreateMeeting"
#define API_URL_UpdateProfile @"api/ProfileAPI/UpdateProfile"
#define API_URL_Reauthorized @"api/ReauthorizeAPI/Reauthorize"

//API Status Code
#define API_Status_Code_00 @"00"
#define API_Status_Code_01 @"01"
#define API_Status_Code_02 @"02"
#define API_Status_Code_03 @"03"
#define API_Status_Code_04 @"04"

//API Params
#define kParam_RegisterModel @"registerModel"
#define kParam_Fullname @"fullName"
#define kParam_Email @"email"
#define kParam_Password @"password"
#define kParam_PhoneNumber @"phone"
#define KParam_Authen @"authMethod"
#define kParam_DeviceId @"deviceId"
#define kParam_UserId @"userId"
#define kParam_AccessToken @"accessToken"
#define kParam_HostUserId @"hostUserId"
#define kParam_StoreId @"storeId"
#define kParam_FriendIds @"friendIds"
#define kParam_EndTime @"endTime"
#define kParam_StartTime @"startTime"
#define kParam_Date @"date"
#define kParam_Desc @"description"
#define kParam_Topic @"topic"
#define kParam_Birthday @"birthday"
#define kParam_Address @"address"
#define kParam_Gender @"gender"
#define kParam_Country @"country"
#define kParam_City @"city"
#define kParam_HID @"hId"

#define kResponse_Data @"data"
#define kResponse_AccessToken @"accessToken"
#define kResponse_AvatarImageLink @"avatarImageLink"
#define kResponse_DisplayName @"displayName"
#define kResponse_Email @"email"
#define kResponse_PhoneNumber @"phoneNumber"
#define kResponse_UserId @"userId"
#define kResponse_Username @"userName"
#define kResponse_Message @"message"
#define kResponse_Status @"status"
#define kResponse_FriendAvatarLinkImage @"avatarLinkImage"
#define kResponse_FriendDisplayName @"displayName"
#define kResponse_FriendStatus @"friendStatus"
#define kResponse_FriendPhoneNumber @"phoneNumber"
#define kResponse_FriendUserId @"userId"

//Response store
#define kResponse_StoreId @"id"
#define kResponse_StoreName @"name"
#define kResponse_StoreAddress @"address"
#define kResponse_StoreLatitude @"latitude"
#define kResponse_StoreLongitude @"longitude"
#define kResponse_StoreFeatureImage @"featureImageLink"
#define kResponse_StoreDescription @"description"
#define kResponse_StorePhone @"phone"
#define kResponse_StoreTwitterUrl @"twitterUrl"
#define kResponse_StoreFacebookUrl @"facebookUrl"
#define kResponse_StoreGoogleUrl @"googleUrl"
#define kResponse_StoreInstagramUrl @"instagramUrl"
#define kResponse_StoreOpenTime @"openTime"
#define kResponse_StoreCloseTime @"closeTime"
#define kResponse_StoreDayInweek @"dayInWeek"
#define kResponse_StoreAvgPrice @"avgPrice"
#define kResponse_StoreRatingScore @"ratingScore"
#define kResponse_StoreDefaultExchangeRate @"defaultExchangeRate"
#define kResponse_StoreDistance @"distance"
#define kResponse_StoreIsFavorite @"isFavorite"
#define kResponse_StoreScoreDetailList @"scoreDetailList"
#define kResponse_StoreScoreDetailList_DecorateCriteria @"decorateCriteria"
#define kResponse_StoreScoreDetailList_LocationCriteria @"locationCriteria"
#define kResponse_StoreScoreDetailList_ServiceCriteria @"serviceCriteria"
#define kResponse_StoreScoreDetailList_QualityCriteria @"qualityCriteria"
#define kResponse_StoreScoreDetailList_CostCriteria @"costCriteria"
#define kResponse_StoreScoreDetailList_CriteriaName @"criteriaName"
#define kResponse_StoreScoreDetailList_Score @"score"
#define kResponse_ClassifyTypeList @"classifyTypeList"
#define kResponse_ClassifyTypeList_ClassifyTypeFilters @"classifyTypeFilters"
#define kResponse_ClassifyTypeList_ClassifyTypeFilters_Id @"id"
#define kResponse_ClassifyTypeList_ClassifyTypeFilters_Name @"name"
#define kResponse_ClassifyTypeList_ClassifyTypeFilters_Classifies @"classifies"
#define kResponse_ClassifyTypeList_ClassifyTypeFilters_Classifies_Id @"id"
#define kResponse_ClassifyTypeList_ClassifyTypeFilters_Classifies_Name @"name"






#endif
