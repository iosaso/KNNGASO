//
// Created by admin on 2017/12/21.
//

#import "AlertManageByUsedVersionTenUp.h"
#import <UIKit/UIKit.h>
#import "../ProcessMsgsnd.h"
#import "../PTFakeMetaTouch.h"
#import "../ASManager.h"
#import "../CFNotificManager.h"
#import "../AsoManger.h"
#import "../GeneralUtil.h"
#import "../Constant.h"


@implementation AlertManageByUsedVersionTenUp {

}
+ (AlertManageByUsedVersionTenUp *)instance {
    static AlertManageByUsedVersionTenUp *_instance = nil;

    @synchronized (self) {
        if (_instance == nil) {
            _instance = [[self alloc] init];
        }
    }

    return _instance;
}

/**
 * 进行处理弹出框相关的设置
 * */
- (void)handleAlertBySimulatedTouch:(id)NG_Alertview {

    UIWindow * window = [[UIApplication sharedApplication] keyWindow];
    if(![window isMemberOfClass:NSClassFromString([GeneralUtil convertHexStrToString:NG_ALERT_SBAlertItemWindow])]) {
        return;
    }



    NSString * mTitle = [NG_Alertview title];
    NSString * mBodyText = [NG_Alertview message];
//    id textField = [NG_Alertview textFields];
    NSArray<UITextField *> * textField = [NG_Alertview textFields];
//    NSArray<UITextField *> * textField = [NG_Alertview textFields];
    NSArray<UIAlertAction *> * alertAction = [(UIAlertController *)NG_Alertview actions];
    // 进行获取当前的Butti
    NSInteger mButtonNumber = [alertAction count];

    id dic =[ProcessMsgsnd getMessage];
    if(!dic){
        return ;
    }

    id mAccount = dic[@"account"];
    id mPassword = dic[@"password"];
//    NSLog(@"-------------------------"
//            "----------------------《title》:《%@》-\n-------------------"
//            "----------------------------《BodyText》:《%@》-\n--------------------------"
//            "----------------------《account》:《%@》 -\n-----------------------"
//            "------------------------《password》:《%@》-\n----------------------"
//            "-----------------------《buttonNumber》:《%ld》",
//            mTitle,mBodyText,mAccount,mPassword,(long)mButtonNumber);
    // 进行设置当前的界面内容
    NSMutableDictionary * labelDic = [NSMutableDictionary dictionaryWithCapacity:8];
    [self findCollectionView:window withDic:labelDic];
    if([self NG_ArrayIsBlanding:alertAction]){
        return;
    }
    // 进行设置登录
    // 进行点击Appid的设置选项，并进行重新安装
    if (([mTitle isEqualToString:@"登录"] || [mTitle isEqualToString:@"Sign In"])
            && mButtonNumber == 3
            ) {
        UILabel * needClickButton =  [labelDic objectForKeyedSubscript:@"使用现有的 Apple ID"];
        if(needClickButton){
            [self simulateTouchButton:needClickButton];
            return;
        }
    }
//     取消按钮  在具有2个按键的前提下会出现
    id cancelButton = nil;
    //确认按钮;
    id confirmButton = nil;
    // 进行获取当前控件的是否取消还是确认
    for(UIAlertAction * alert in alertAction){
        switch([alert style]){
            case UIAlertActionStyleDefault:
                //确认按钮
                confirmButton = [labelDic objectForKeyedSubscript:[alert title]];
                break;
            case UIAlertActionStyleCancel:
                // 取消按钮  在具有2个按键的前提下会出现
                cancelButton = [labelDic objectForKeyedSubscript:[alert title]];
                break;
            case UIAlertActionStyleDestructive:
                // 暂未知
                break;
            default:
                break;
        }
    }
//     进行设置当前的界面内容
    if (([mTitle isEqualToString:@"Apple ID 密码"]
            || [mTitle isEqualToString:@"登录 iTunes Store"]
            || [mTitle isEqualToString:@"Sign In to iTunes Store"])
            &&  mButtonNumber == 2) {
        // 进行登录当前的账户信息
        if(mBodyText && [mBodyText hasPrefix:@"请输入您 Apple ID“"]  && [mBodyText hasSuffix:@"”的密码。"]){
            if (!mAccount  || [mBodyText rangeOfString:mAccount].location == NSNotFound) {
                [self simulateTouchButton:cancelButton ];
                [[ASManager instance] signOutAllAcount];
                [[AsoManager sharedInstance] clearAndRestartRequest];
                return;
            }
        }
        if([self NG_ArrayIsBlanding:textField]){
            return;
        }
        // 进行输入账号密码
        NSInteger  textFieldCount = [textField count];
        if(textFieldCount  == 2){
            textField[0].text = mAccount;
            textField[1].text = mPassword;
//            [textField objectAtIndex:0].text = mAccount;
//            [textField objectAtIndex:1].text = mPassword;

        }
        if(textFieldCount  == 1){
            textField[0].text = mPassword;
        }
        [self simulateTouchButton:confirmButton ];
        return;
    }

    if (([mTitle isEqualToString:@"是否为免费项目保存密码？"]
            || [mTitle isEqualToString:@"Save Password for Free Items"])
            &&([mBodyText isEqualToString:@"您可以随时通过“设置”App 中的“iTunes Store 与 App Store”更改此设置。"]
            || [mBodyText isEqualToString:@"You can change this at any time in iTunes and App Store in the Settins app"]
            || [mBodyText isEqualToString:@"You can change this at any time in iTunes and App Store in the Settins app."])
            &&  mButtonNumber == 2) {



        UILabel * needClickButton =  [labelDic objectForKeyedSubscript:@"始终需要"]?
                [labelDic objectForKeyedSubscript:@"始终需要"]: [labelDic objectForKeyedSubscript:@"否"];

//        if (needClickButton == nil){
//                  needClickButton =  [labelDic objectForKeyedSubscript:@"否"];
//        }
        if(!needClickButton){
            return;
        }
        [self simulateTouchButton:needClickButton ];
        return;
    }

    if (([mTitle isEqualToString:@"在此设备上的其他购买是否需要密码？"]
            ||[mTitle isEqualToString:@"このデバイス上で追加の購入を行うときにパスワードの入力を要求しますか？"]
            ||[mTitle isEqualToString:@"Passwort für weitere Käufe auf diesem Gerät anfordern?"]
            ||[mTitle isEqualToString:@"Require password for additional purchases on this device?"]
            ||[mTitle isEqualToString:@"Запрашивать пароль для других покупок на этом устройстве?"])
            && ([mBodyText isEqualToString:@"您可以随时通过“设置”App 中的“iTunes Store 与 App Store”更改此设置。"]
            ||[mBodyText isEqualToString:@"この設定は「設定」App の「iTunes & App Store」でいつでも変更できます。"]
            ||[mBodyText isEqualToString:@"Dies kann jederzeit in den Einstellungen unter „iTunes & App Store“ geändert werden."]
            ||[mBodyText isEqualToString:@"You can change this at any time in iTunes and App Store in the Settings app."]
            ||[mBodyText isEqualToString:@"You can change this at any time in iTunes and App Store in the Settings app"]
            ||[mBodyText isEqualToString:@"You can change this at any time in iTunes & App Store in the Settings app."]
            ||[mBodyText isEqualToString:@"Вы всегда можете изменить настройки запроса пароля в разделе «iTunes Store и App Store» приложения «Настройки»."])
            && mButtonNumber== 2) {
        UILabel * needClickButton =  [labelDic objectForKeyedSubscript:@"始终需要"];
        [self simulateTouchButton:needClickButton ];
        [self onClickDownloadForTwo];
        return;
    }
    if (([mTitle isEqualToString:@"iTunes 条款和条件已有更改"]
            ||[mTitle isEqualToString:@"iTunes 條款和條件已經更改"]
            ||[mTitle isEqualToString:@"iTunes Terms & Conditions Have Changed"]
            ||[mTitle isEqualToString:@"Termini e Condizioni di iTunes sono cambiati"]
            ||[mTitle isEqualToString:@"Die iTunes allgemeinen Geschäftsbedingungen sind geändert worden."]
            ||[mTitle isEqualToString:@"Les Conditions générales d'iTunes ont été modifiées"]
            ||[mTitle isEqualToString:@"iTunes 使用許諾契約書が更新されました。"]
            ||[mTitle isEqualToString:@"Los Términos y condiciones de iTunes han cambiado"]
            ||[mTitle isEqualToString:@"iTunes 이용 약관이 변경됨"])
            && ([mBodyText isEqualToString:@"您必须阅读并接受新的条款与条件，才能继续进行"]
            ||[mBodyText isEqualToString:@"您必須閱讀並接受新的條款和條件，才能夠繼續"]
            ||[mBodyText isEqualToString:@"Before you can proceed you must read & accept the new Terms & Conditions"]
            ||[mBodyText isEqualToString:@"Prima di poter procedere devi leggere e accettare i nuovi Termini e condizioni"]
            ||[mBodyText isEqualToString:@"Sie müssen die neuen Geschäftsbedingungen lesen und akzeptieren, bevor Sie fortfahren können."]
            ||[mBodyText isEqualToString:@"Avant de continuer, vous devez lire et accepter les nouvelles Conditions générales."]
            ||[mBodyText isEqualToString:@"続けるには利用規約をお読みの上、同意いただく必要があります"]
            ||[mBodyText isEqualToString:@"Voordat u door kunt gaan, moet u de nieuwe Algemene Voorwaarden lezen en ermee akkoord gaan."]
            ||[mBodyText isEqualToString:@"Antes de continuar debes leer y aceptar los nuevos términos y condiciones"]
            ||[mBodyText isEqualToString:@"계속하려면 새로운 이용 약관을 읽고 동의해야 합니다."])
            &&  mButtonNumber == 2){
        [self simulateTouchButton:cancelButton ];
        // 应该进行重新的请求任务
        [[AsoManager sharedInstance] failByDes:@"iTunes 条款和条件已有更改"];
        return;
    }
    if (([mTitle isEqualToString:@"Apple 媒体服务条款与条件已更改。"]
            ||[mTitle isEqualToString:@"Die allgemeinen Geschäftsbedingungen der Apple-Mediendienste haben sich geändert."]
            ||[mTitle isEqualToString:@"Apple Media Services Terms and Conditions have changed."]
            ||[mTitle isEqualToString:@"Apple メディアサービスの利用規約が変更されました。"]
            ||[mTitle isEqualToString:@"Положения и условия мультимедийных сервисов Apple изменены"])
            &&([mBodyText isEqualToString:@"您必须阅读并接受新的条款与条件，才能继续进行"]
            ||[mBodyText isEqualToString:@"Sie müssen die neuen Geschäftsbedingungen lesen und akzeptieren, bevor Sie fortfahren können."]
            ||[mBodyText isEqualToString:@"Before you can proceed you must read and accept the new Terms & Conditions."]
            ||[mBodyText isEqualToString:@"続けるには利用規約をお読みの上、同意いただく必要があります"]
            ||[mBodyText isEqualToString:@"Прежде чем продолжить, необходимо прочесть новые Положения и условия и принять их"])
            && mButtonNumber == 2){
        [self simulateTouchButton:cancelButton ];
        // 应该进行重新的请求任务
        [[AsoManager sharedInstance] failByDes:@"Apple媒体条款已经更改"];
        return;
    }
    if (([mTitle isEqualToString:@"iTunes Store"]
            || [mTitle isEqualToString:@"是否要在此设备上启用自动下载功能？"]
            || [mTitle isEqualToString:@"Möchten Sie auf diesem Gerät automatische Downloads aktivieren?"]
            || [mTitle isEqualToString:@"登录以启用“自动下载”"]
            || [mTitle isEqualToString:@"登入以啟用「自動下載」"]
            || [mTitle isEqualToString:@"Sign In to Enable Automatic Downloads"]
            || [mTitle isEqualToString:@"Connectez-vous pour activer la fonction Téléchargements automatiques"]
            || [mTitle isEqualToString:@"Accedi per attivare il Download automatico"]
            || [mTitle isEqualToString:@"您已购买过此项目，所以现在可以免费下载，不再另外收费。"]
            || [mTitle isEqualToString:@"您已購買過此項目，所以現在可以免費下載，不再另外收費。"]
            || [mTitle isEqualToString:@"You've already purchased this, so it will be downloaded now at no additional charge."]
            || [mTitle isEqualToString:@"Poiché hai già effettuato questo acquisto, il download sarà effettuato senza ulteriori addebiti."]
            || [mTitle isEqualToString:@"Vous avez déjà acheté et article, il sera donc téléchargé sans frais supplémentaires."]
            || [mTitle isEqualToString:@"このアイテムはすでに購入されているため、無料でダウンロードされます。"]
            || [mTitle isEqualToString:@"U heeft dit al gekocht en dus wordt het nu zonder extra kosten gedownload."]
            || [mTitle isEqualToString:@"Sie haben diesen Artikel bereits gekauft, deshalb wird er jetzt kostenlos erneut geladen."]
            || [mTitle isEqualToString:@"이미 이 항목을 구입했으며 지금 추가 비용 없이 다운로드합니다."])
            &&([mBodyText isEqualToString:@"您已从您的设备上下载了一个 App。开启自动下载可在此设备上接收 App而无需同步。"]
            ||[mBodyText isEqualToString:@"您在另一個裝置下載了 App。 開啟「自動下載」可在此裝置接收 App，不需同步。"]
            ||[mBodyText isEqualToString:@"You downloaded an app on another device. Turn on Automatic Downloads to receive apps on this device without having to sync."]
            ||[mBodyText isEqualToString:@"You downloaded an app from another device. Turn on Automatic Downloads to receive apps on this device without having to sync."]
            ||[mBodyText isEqualToString:@"Vous avez téléchargé une app sur votre appareil. Activez les téléchargements automatiques pour recevoir vos apps sur cet appareil sans le synchroniser."]
            ||[mBodyText isEqualToString:@"您从其他 iOS 设备下载了一个 App。若要在此设备上直接获得 App，请开启“自动下载”。"]
            ||[mBodyText isEqualToString:@"立即启用，以自动下载在其他设备上购买的新内容，或者随时前往“设置”>“iTunes Store 与 App Store”。"]
            ||[mBodyText isEqualToString:@"Aktivieren Sie jetzt, um automatisch auf anderen Geräten getätigte neue Käufe zu laden oder gehen Sie jederzeit zu „Einstellungen“ > „iTunes & App Store“."]
            ||[mBodyText isEqualToString:@"轻按“好”并登录，以在此设备上启用“自动下载”。"]
            ||[mBodyText isEqualToString:@"在裝置上點一下「好」並登入以啟用「自動下載」。"]
            ||[mBodyText isEqualToString:@"Tap OK and sign in to enable Automatic Downloads on this device."]
            ||[mBodyText isEqualToString:@"Tap OK and sign in to enable  Automatic Downloads on this device."]
            ||[mBodyText isEqualToString:@"Touchez OK et connectez-vous pour activer la fonction Téléchargements automatiques sur cet appareil."]
            ||[mBodyText isEqualToString:@"Tocca su OK, quindi accedi per attivare il Download automatico su questo dispositivo."])
            && mButtonNumber == 2){
        [self simulateTouchButton:cancelButton ];
        return;
    }

    if (([mTitle isEqualToString:@"由于您拥有此项目之前的版本，所以此次更新免费。要立即更新，选择“确定”。"]
            || [mTitle isEqualToString:@"您已购买此项目。若要再次免费下载，请选择“好”。"]
            || [mTitle hasSuffix:@"包含受年龄限制的内容"]
            || [mTitle hasSuffix:@"重要事項： 此產品包含 17 歲以下兒童可能感到反感的內容。"]
            || [mTitle hasSuffix:@"contains age-restricted material."]
            || [mTitle hasSuffix:@"contiene materiale vietato ai minori."]
            || [mTitle hasSuffix:@"n’est pas approprié pour tous les âges."]
            || [mTitle hasSuffix:@"ist eine Altersbeschränkung vorgesehen."]
            || [mTitle hasSuffix:@"には年齢制限のある内容が含まれています。"]
            || [mTitle hasSuffix:@"contiene material sólo para adultos."]
            || [mTitle hasSuffix:@"bevat leeftijdsgebonden materiaal."]
            || [mTitle hasSuffix:@"에 나이 제한이 있는 자료가 포함되어 있습니다."])
            &&([mBodyText isEqualToString:@"You can update this software application for free. Would you like to update it?"]
            ||[mBodyText isEqualToString:@"您可以免费更新此应用软件。是否想要更新？"]
            ||[mBodyText isEqualToString:@"点一下“好”确认您已满17岁。您的内容将立即开始下载。"]
            ||[mBodyText isEqualToString:@"點一下「好」以確認您已年滿 17 歲。 將立即開始下載您的內容。"]
            ||[mBodyText isEqualToString:@"Tap OK to confirm that you are 17 or over. Your content will then begin downloading immediately."]
            ||[mBodyText isEqualToString:@"Tocca OK per confermare che hai più di 17 anni. Potrai quindi scaricare il contenuto immediatamente."]
            ||[mBodyText isEqualToString:@"Touchez OK pour confirmer que vous avez au moins 17 ans. Le téléchargement de votre contenu débutera alors immédiatement."]
            ||[mBodyText isEqualToString:@"Tippen Sie auf „OK“, um zu bestätigen, dass Sie mindestens 17 Jahre alt sind. Ihr Inhalt wird darauf hin sofort geladen."]
            ||[mBodyText isEqualToString:@"「OK」をタップすることにより、利用者は17歳以上であることを認めたものとみなされ、コンテンツのダウンロードがただちに開始されます。"]
            ||[mBodyText isEqualToString:@"Pulsa OK para confirmar que tienes al menos 17 años. Tu contenido empezará a descargarse inmediatamente."]
            ||[mBodyText isEqualToString:@"Tik OK om te bevestigen dat je 17 jaar of ouder bent. Jouw content zal dan onmiddellijk beginnen te downloaden."]
            ||[mBodyText isEqualToString:@"[승인]을 클릭하여 17세 이상임을 확인하시면 다운로드가 즉시 시작됩니다."])
            && mButtonNumber== 2){
        [self simulateTouchButton:cancelButton ];
        return;
    }

    if ([mTitle hasPrefix:@"您购买"]
            && [mTitle hasSuffix:@"的交易无法完成。"]
            && [mTitle hasPrefix:@"您帐户金额不足，不能进行此次购物。如需为您的帐户充值，请点击“充值”。"]
            && mButtonNumber == 2){
        [self simulateTouchButton:cancelButton ];
        [[AsoManager sharedInstance] failByDes:@"账户被禁用"];
        return;
    }
    if ([mTitle hasPrefix:@"需要登录"]
            && mButtonNumber == 2){
        [self simulateTouchButton:cancelButton ];
        return;
    }

    if (([mTitle isEqualToString:@"无法下载项目"]
            || [mBodyText isEqualToString:@"请稍后再试。"])
            && mButtonNumber == 2){
        [self simulateTouchButton:cancelButton ];
        [[AsoManager sharedInstance] failByDes:@"无法下载项目"];
        return;
    }

    if (([mTitle isEqualToString:@"此 Apple ID 尚未在 iTunes 商店使用过。"]
            || [mBodyText isEqualToString:@"轻点“检查”以登录，然后检查您的帐户信息。"])
            && mButtonNumber == 2){
        [self simulateTouchButton:cancelButton ];
        [self onClickDownloadForTwo];
        return;
    }
    if (( [mTitle hasPrefix:@"此 Apple ID 只能在 iTunes Store "]
            || [mTitle hasSuffix:@"店面购物。您将被转至该店面。"]
            || [mTitle hasPrefix:@"Uw Apple ID is slechts geldig voor aankopen in de"]
            || [mTitle hasSuffix:@"iTunes Store. U wordt naar die winkel gebracht."]
            || [mTitle hasPrefix:@"This Apple ID is only valid for purchases in the"]
            || [mTitle hasSuffix:@"iTunes Store. You will be switched to that Store."]
            || [mTitle hasPrefix:@"Diese Apple-ID kann nur für Einkäufe im"]
            || [mTitle hasSuffix:@"iTunes Store verwendet werden. Sie werden zu diesem Store weitergeleitet."]
            || [mTitle hasPrefix:@"Questo ID Apple è valido solo per gli acquisti nell'iTunes Store"]
            || [mTitle hasSuffix:@". Verrai trasferito automaticamente a quello Store."]
            || [mTitle hasPrefix:@"Cet identifiant Apple ne peut être utilisé que pour des achats dans l’iTunes Store"]
            || [mTitle hasSuffix:@". Vous allez être redirigé vers ce Store."]
            || [mTitle hasPrefix:@"이 Apple ID는"]
            || [mTitle hasSuffix:@"iTunes Store에서 구입하는 경우에만 사용할 수 있습니다. 해당 스토어로 이동합니다."]
            || [mTitle hasPrefix:@"此 Apple ID 只能在"]
            || [mTitle hasSuffix:@"的 iTunes Store 购买项目。您将转至该 Store。"]
            || [mTitle hasSuffix:@"のの iTunes Store でのみご利用になれます。有効な Store へ移動します。"]
            || [mTitle hasPrefix:@"此 Apple ID 只能在 iTunes Store"]
            || [mTitle hasSuffix:@"店面购物。您将转往该店面，然后请重新尝试购买。"]
            || [mTitle hasSuffix:@"店面購買。您將轉往該店面，然後請重新嘗試購買。"]
            || [mTitle hasSuffix:@". iTunes Store. You will be switched to that Store. Try your purchase again."]
            || [mTitle hasPrefix:@"This Apple ID is only valid for purchases in the"]
            || [mTitle hasPrefix:@"Il tuo ID Apple è valido solo per gli acquisti nell'iTunes Store"]
            || [mTitle hasSuffix:@". Toccando OK andrai direttamente a questo Store."]
            || [mTitle hasPrefix:@"Ihr Account ist nur für den Einkauf im iTunes Store für"]
            || [mTitle hasSuffix:@"gültig. Durch Tippen auf OK werden Sie zu diesem Store geleitet."]
            || [mTitle hasPrefix:@"Cet identifiant Apple ne peut être utilisé que pour des achats dans l’iTunes Store"]
            || [mTitle hasSuffix:@". Vous allez être redirigé vers ce Store. Veuillez réessayer votre achat."]
            || [mTitle hasPrefix:@"此 Apple ID 只可在"]
            || [mTitle hasPrefix:@"この Apple ID は"]
            || [mTitle hasSuffix:@"的 iTunes Store 中進行購買。系統會將您轉至該商店。"]
            || [mTitle hasSuffix:@"の iTunes Store でのみご利用になれます。有効な Store へ移動します。"])
            && mButtonNumber == 1){
        [self simulateTouchButton:confirmButton ];
        return;
    }
    if ( [mTitle hasPrefix:@"Diese Apple-ID kann nur für Einkäufe"]
            && [mTitle hasSuffix:@"iTune Store verwendet werden. Du wirst zu diesem Store weitergeleitet."]
            && mButtonNumber == 1){
        [self simulateTouchButton:confirmButton ];
        return;
    }
    if (( [mTitle hasPrefix:@"Questo prodotto non è disponibile nello Store"]
            || [mTitle hasPrefix:@"Ce produit n’est pas disponible dans le Store de"])
            && mButtonNumber == 1){
        [self simulateTouchButton:confirmButton ];
        [[AsoManager sharedInstance] failByDes:@"产品对应商店不对"];
        return;
    }
    if (( [mTitle isEqualToString:@"このストアのアカウントではありません"]
            || [mTitle isEqualToString:@"帐户不在此店面"]
            || [mTitle isEqualToString:@"帳號不在此店面"]
            || [mTitle isEqualToString:@"Account Not In This Store"]
            || [mTitle isEqualToString:@"Compte non utilisable dans ce pays"]
            || [mTitle isEqualToString:@"Account nicht in diesem Store"]
            || [mTitle isEqualToString:@"Questo account non appartiene a questo Store."])
            && ([mBodyText hasPrefix:@"アカウントは"]
            || [mBodyText hasSuffix:@"Store。"]
            || [mBodyText hasSuffix:@"の のストアに切り替える必要があります。"]
            || [mBodyText hasSuffix:@"店面。"]
            || [mBodyText hasSuffix:@"store before purchasing."]
            || [mBodyText hasSuffix:@"Your account is not valid for use in the"]
            || [mBodyText hasSuffix:@"store before purchasing."]
            || [mBodyText hasSuffix:@"pour pouvoir faire des achats."]
            || [mBodyText hasSuffix:@"wechseln, um Käufe tätigen zu können."]
            || [mBodyText hasSuffix:@"prima di poter effettuare l'acquisto."]
            || [mBodyText hasPrefix:@"您的帐户在"]
            || [mBodyText hasPrefix:@"Your account is not valid for use in the"]
            || [mBodyText hasPrefix:@"Votre compte ne peut pas être utilisé dans le store"]
            || [mBodyText hasPrefix:@"Ihr Account ist nicht für Einkäufe im Store für"]
            || [mBodyText hasPrefix:@"Il tuo account non può essere usato per lo Store"]
            || [mBodyText rangeOfString:@"无法使用。购买之前，您必须切换到"].location != NSNotFound
            || [mBodyText rangeOfString:@"の のストアではご使用になれません。購入する前に、"].location != NSNotFound
            || [mBodyText rangeOfString:@"Store 无法使用。购买之前，您必须切换到"].location != NSNotFound
            || [mBodyText rangeOfString:@"面使用。開始進行購買前，您必須先切換到"].location != NSNotFound
            || [mBodyText rangeOfString:@"store.  You must switch to the"].location != NSNotFound
            || [mBodyText rangeOfString:@". Vous devez passer au store"].location != NSNotFound
            || [mBodyText rangeOfString:@"gültig. Sie müssen in den Store für"].location != NSNotFound
            || [mBodyText rangeOfString:@".  Devi passare allo Store"].location != NSNotFound
            || [mBodyText rangeOfString:@""].location != NSNotFound
            || [mBodyText rangeOfString:@""].location != NSNotFound
            || [mBodyText rangeOfString:@""].location != NSNotFound)
            && mButtonNumber == 1){
        [self simulateTouchButton:confirmButton ];
        [[AsoManager sharedInstance] failByDes:@"无此商品"];
        return;
    }

    if ( [mTitle isEqualToString:@"低电池电量"]
            && [mBodyText hasSuffix:@"电池电量"]
            && mButtonNumber == 1){
        [self simulateTouchButton:confirmButton ];
        return;
    }

    if ( [mTitle isEqualToString:@"电池电量不足"]
            && [mBodyText hasSuffix:@"仅剩"]
            && mButtonNumber == 2){
        [self simulateTouchButton:cancelButton ];
        return;
    }
    if ( [mTitle isEqualToString:@"预置描述文件的有效期"]
            && mButtonNumber == 2){
        [self simulateTouchButton:cancelButton ];
        return;

    }
    if (( [mTitle isEqualToString:@"未安装SIM卡"]
            || [mTitle isEqualToString:@"未安装 SIM卡"]
            || [mTitle isEqualToString:@"未安装SIM 卡"]
            || [mTitle isEqualToString:@"未安装 SIM 卡"])
            && mButtonNumber == 2){
        [self simulateTouchButton:cancelButton ];
        return;

    }
    if ( [mTitle isEqualToString:@"运营商设置更新"]
            && [mTitle isEqualToString:@"已有新的设置可供下载。您想现在更新设置吗"]
            && mButtonNumber == 2){
        [self simulateTouchButton:cancelButton ];
        return;
    }
    if ([mTitle isEqualToString:@"验证失败"]
            && [mBodyText isEqualToString:@"One of the required resources is busy/not available to complete your request. Please try after a moment."]
            && mButtonNumber == 2) {
        [self simulateTouchButton:confirmButton ];
        return;
    }
    if ([mTitle isEqualToString:@"您的 Apple ID 已被停用。"]
            || [mTitle isEqualToString:@"您的 Apple ID 已停用。"]
            || [mTitle isEqualToString:@"Your Apple ID has been disabled."]
            || [mTitle isEqualToString:@"Il tuo ID Apple è stato disabilitato."]
            || [mTitle isEqualToString:@"Votre identifiant Apple a été désactivé."]
            || [mTitle isEqualToString:@"ご利用の Apple ID は無効にされています。"]
            || [mTitle isEqualToString:@"Ihre Apple-ID wurde deaktiviert."]
            || [mTitle isEqualToString:@"Tu Apple ID ha sido desactivado."]
            || [mTitle isEqualToString:@"Tu ID de Apple se ha desactivado."]
            ) {
        if(mButtonNumber == 1){
            [self simulateTouchButton:confirmButton ];
        } else{
            [self simulateTouchButton:cancelButton ];
        }
        // 产品对应商店不对
        [[AsoManager sharedInstance] failByDes:@"Apple ID 已经停用"];
        return;
    }
    if ([mTitle isEqualToString:@"验证失败"]
            && [mBodyText isEqualToString:@"您的 Apple ID 或密码不正确。"]
            && mButtonNumber == 2) {
        [self simulateTouchButton:cancelButton ];
        // 产品对应商店不对
        [[AsoManager sharedInstance] failByDes:@"无此商品"];
        return;
    }
    if ([mTitle isEqualToString:@"验证 Apple ID"]
            && [mBodyText hasPrefix:@"打开“设置”以继续使用“"]
            && mButtonNumber == 2) {
        [self simulateTouchButton:cancelButton ];
        [[AsoManager sharedInstance] failByDes:@"验证 Apple ID"];
        return;

    }
    if ([mTitle isEqualToString:@"无法连接到 iTunes Store"] &&
            mButtonNumber == 1) {
        [self simulateTouchButton:confirmButton ];
        [[AsoManager sharedInstance] failByDes:@"无法连接到 iTunes Store"];
        return;
    }
    if ([mTitle isEqualToString:@"无法连接到 iTunes Store"] &&
            mButtonNumber == 2) {
        [self simulateTouchButton:cancelButton ];
        [[AsoManager sharedInstance] failByDes:@"无法连接到 iTunes Store"];
        return;
    }
    if (([mTitle hasPrefix:@"无法购买"] ||
            [mTitle hasPrefix:@"無法購買"] ||
            [mTitle hasPrefix:@"Unable to Purchase"] )&&
            mButtonNumber == 1) {
        [self simulateTouchButton:confirmButton ];
        [[AsoManager sharedInstance] failByDes:@"无法购买"];
        return;
    }

    if ([mTitle isEqualToString:@"无法下载应用"]  &&
            [mBodyText hasPrefix:@"此时无法安装"] &&
            mButtonNumber == 1) {
        [self simulateTouchButton:confirmButton ];
        [[AsoManager sharedInstance] failByDes:@"无法下载应用"];
        return;
    }
    if ([mTitle isEqualToString:@"无法下载应用"]  &&
            [mBodyText hasPrefix:@"此时无法安装"] &&
            mButtonNumber == 2) {
        [self simulateTouchButton:cancelButton ];
        [[AsoManager sharedInstance] failByDes:@"无法下载应用"];
        return;
    }
    if ([mTitle isEqualToString:@"验证失败"] &&(
            [mBodyText isEqualToString:@"Internal error occurred, Refer the Error Code"] ||
                    [mBodyText isEqualToString:@"This Action Cannot Be Completed"] )&&
            mButtonNumber == 2) {
        [self simulateTouchButton:cancelButton ];
        return;
    }

    if ([mTitle isEqualToString:@"验证失败"]
            &&([mBodyText isEqualToString:@"您的 Apple ID 或密码不正确。"])&&
            mButtonNumber == 2) {
        [self simulateTouchButton:cancelButton ];
        return;
    }
    if ([mTitle isEqualToString:@"验证 Apple ID"]
            &&([mBodyText hasPrefix:@"打开“设置”以继续使用“"])&&
            mButtonNumber == 2) {
        [self simulateTouchButton:cancelButton ];
        return;
    }
    if ([mTitle isEqualToString:@"验证失败"]
            &&([mBodyText isEqualToString:@"连接 Apple ID 服务器时出错。"])&&
            mButtonNumber == 2) {
        [self simulateTouchButton:cancelButton ];
        return;

    }
    if ([mTitle isEqualToString:@"验证失败"]
            &&([mBodyText isEqualToString:@"此 Apple ID 已由于安全原因被禁用。 请访问 iForgot 重新设置您的账户 (http://iforgot.apple.com)。"]
            ||[mBodyText isEqualToString:@"This Apple ID has been locked for security reasons. Visit iForgot to reset your account (https://iforgot.apple.com)."])&&
            mButtonNumber == 2) {
        [self simulateTouchButton:cancelButton ];

        // 帐户已被锁定，联系客户支持
        [[AsoManager sharedInstance] failByDes:@"此 Apple ID 已由于安全原因被禁用"];
        return;
    }
    if (([mTitle isEqualToString:@"您的帐户已被禁用。"]
            || [mTitle isEqualToString:@"Votre compte a été désactivé."]
            || [mTitle isEqualToString:@"Your account is disabled."]
            || [mTitle isEqualToString:@"アカウントが無効になっています。"]
            || [mTitle isEqualToString:@"已停用您的帳號。"]
            || [mTitle isEqualToString:@"Il tuo account è stato disabilitato."]
            || [mTitle isEqualToString:@"Ihr Account ist deaktiviert."]
            || [mTitle isEqualToString:@"귀하의 계정은 사용할 수 없습니다."])
            &&([mBodyText isEqualToString:@"此 Apple ID 已由于安全原因被禁用。 轻敲“重设”以重新设置您的帐户。"]
            ||[mBodyText isEqualToString:@"Cet identifiant Apple a été désactivé pour des raisons de sécurité. Touchez Réinitialiser pour réinitialiser votre compte."]
            ||[mBodyText isEqualToString:@"This Apple ID has been disabled for security reasons. Tap Reset to reset your account."]
            ||[mBodyText isEqualToString:@"セキュリティ上の理由から、この Apple ID は無効になっています。「リセット」をタップするとアカウントをリセットできます。"]
            ||[mBodyText isEqualToString:@"此 Apple ID 由於安全性問題已經停用。點一下「重置」以重置您的帳號。"]
            ||[mBodyText isEqualToString:@"Questo ID Apple è stato disabilitato per motivi di sicurezza. Tocca Reimposta per reimpostare il tuo account."]
            ||[mBodyText isEqualToString:@"Diese Apple ID wurde aus Sicherheitsgründen deaktiviert. Tippen Sie auf „Zurücksetzen“, um Ihren Account zurückzusetzen."]
            ||[mBodyText isEqualToString:@"Diese Apple-ID wurde aus Sicherheitsgründen deaktiviert. Tippen Sie auf „Zurücksetzen“, um Ihren Account zurückzusetzen."]
            ||[mBodyText isEqualToString:@"이 Apple ID는 보안 상의 이유로 사용할 수 없게 되었습니다. 계정을 재설정하려면 재설정을 탭하십시오."] )
            && mButtonNumber == 2) {
        [self simulateTouchButton:cancelButton ];
        //帐户被禁用
        [[AsoManager sharedInstance] failByDes:@"您的帐户已被禁用"];
        return;
    }
    if (([mTitle isEqualToString:@"验证失败"])
            &&([mBodyText isEqualToString:@"This request could not be completed because of a server error."]
            ||[mBodyText isEqualToString:@"发生未知错误。"])
            && mButtonNumber == 2) {
        [self simulateTouchButton:cancelButton ];
        // 任务超时 则重新开始
        [[AsoManager sharedInstance] failByDes:@"验证失败  发生未知错误"];
        return;
    }
    if (([mTitle isEqualToString:@"未能登录"])
            &&([mBodyText isEqualToString:@"发生未知错误"])
            && mButtonNumber == 1) {
        [self simulateTouchButton:confirmButton ];
        // 任务超时 则重新开始
        [[AsoManager sharedInstance] failByDes:@"未能登录  发生未知错误"];
        return;
    }
    if ([mTitle isEqualToString:@"未能登录"]&& mButtonNumber == 1) {
        [self simulateTouchButton:confirmButton ];
        // 任务超时 则重新开始
//        [self onClickDownloadForTwo];
        [[AsoManager sharedInstance] failByDes:@"未能登录 "];
        return;
    }



    if (([mTitle isEqualToString:@"您的 Apple ID 或密码不正确。"]
            ||[mTitle isEqualToString:@"Your Apple ID or password is incorrect."])
            && mButtonNumber == 2) {
        [self simulateTouchButton:cancelButton ];
        // 帐号密码不正确 则重新开始
        [[AsoManager sharedInstance] failByDes:@"您的 Apple ID 或密码不正确。"];
        return;
    }

    if (([mTitle isEqualToString:@"验证失败"])
            &&([mBodyText isEqualToString:@"This action could not be completed. Try again."]
            ||[mBodyText isEqualToString:@"This Action Cannot Be Completed"] )
            && mButtonNumber == 2) {
        [self simulateTouchButton:cancelButton ];
        // 任务超时 则重新开始
        [[AsoManager sharedInstance] failByDes:@"验证失败"];
        return;
    }
//
    if (([mTitle isEqualToString:@"无法使用此 Apple ID 进行更新"]
            || [mTitle isEqualToString:@"Für diese Apple-ID steht kein Update zur Verfügung"])
            &&([mBodyText isEqualToString:@"Dieses Update steht für diese Apple-ID nicht zur Verfügung, da es von einem anderen Benutzer gekauft oder der Artikel zurückerstattet oder storniert wurde."]
            ||[mBodyText isEqualToString:@"此更新不适用于此 Apple ID，因为该项目是由其他用户购买，或已退款或取消。"])
            && mButtonNumber == 1) {
        [self simulateTouchButton:confirmButton ];
        // 已退款或取消 则重新开始
        [[AsoManager sharedInstance] failByDes:@"无法使用此 Apple ID 进行更新"];
        return;
    }

    if (([mTitle isEqualToString:@"您尚未验证自己的 Apple ID。"])
            &&([mBodyText isEqualToString:@"点一下“好”查看如何验证 Apple ID 的说明。"])
            && mButtonNumber == 2) {
        [self simulateTouchButton:cancelButton ];
        // 需要验证 则重新开始
        [[AsoManager sharedInstance] clearAndRestartRequest];
        return;
    }
    if (([mTitle isEqualToString:@"iTunes Store"])
            &&([mBodyText isEqualToString:@"您从其他 iOS 设备下载了一个 App。若要在此设备上直接获得 App，请开启“自动下载的项目”。"])
            && mButtonNumber == 2) {
        [self simulateTouchButton:cancelButton ];
        return;
    }
    if (([mTitle isEqualToString:@"安装"]
            || [mTitle isEqualToString:@"获取"])
            &&([mBodyText isEqualToString:@"我们需要先进行一个简短的验证。"])
            && mButtonNumber == 2) {
        [self simulateTouchButton:cancelButton ];
        return;
    }

    if (([mTitle isEqualToString:@"此 Apple ID 尚未在 iTunes Store 使用过。"]
            || [mTitle isEqualToString:@"使用过。"])
            &&([mBodyText isEqualToString:@"轻点“检查”登录，然后检查您的帐户信息。"]
            ||[mBodyText isEqualToString:@"然后检查您的帐户信息。"])
            && mButtonNumber == 2) {
        [self simulateTouchButton:cancelButton ];
        // AppleID尚未使用过
        [[AsoManager sharedInstance] failByDes:@"此 Apple ID 尚未在 iTunes Store 使用过。"];
        return;
    }

    if ([mTitle isEqualToString:@"需要验证"]
            &&[mBodyText isEqualToString:@"必须轻点“继续”以验证您的付款信息，才能进行购买。"]
            && mButtonNumber == 2) {
        [self simulateTouchButton:cancelButton ];
        // AppleID尚未使用过
        [[AsoManager sharedInstance] failByDes:@"需要验证"];
        return;
    }
    if (([mTitle isEqualToString:@"输入错误次数过多"])
            &&([mBodyText isEqualToString:@"您的 Apple ID 已被暂时禁止获取免费 App。请稍后再试。"])
            && mButtonNumber == 1) {
        [self simulateTouchButton:confirmButton ];
        // 输入错误次数过多
        [[AsoManager sharedInstance] failByDes:@"输入错误次数过多"];
        return;
    }
    // 如果未检测到
    if(mButtonNumber == 1){
        [self simulateTouchButton:confirmButton ];
    }else{
        [self simulateTouchButton:cancelButton ];
    }

//    [[AsoManager sharedInstance] failByDes:[NSString stringWithFormat:@"未识别的弹出框 title：%@  body:%@ number:%ld" ,mTitle,mBodyText,(long)mButtonNumber]];
}

-(void)onClickDownloadForTwo{
    [self performSelector:@selector(onClick) withObject:nil afterDelay:0.3];
    [self performSelector:@selector(onClick) withObject:nil afterDelay:0.5];
}

-(void)onClick{
    [CFNotificManager SendMessage:TOUCH_CLICK_DOWNLOAD_BUTTON];
}




/**
 *
 * 获取控件的位置进行模拟触碰
 * */
-(void)simulateTouchButton:(id)NG_NeedTouchButton {
    UIWindow * windoddw= [self NG_LastWindow];
    CGRect rect=[NG_NeedTouchButton convertRect: [NG_NeedTouchButton bounds] toView:windoddw];
    float x = (NSInteger)(rect.origin.x+[NG_NeedTouchButton frame].size.width/2);
    float y =(NSInteger)(rect.origin.y+[NG_NeedTouchButton frame].size.height/2);
    NSInteger pointId = [PTFakeMetaTouch fakeTouchId:[PTFakeMetaTouch getAvailablePointId] AtPoint:CGPointMake(x,y) withTouchPhase:UITouchPhaseBegan];
    [PTFakeMetaTouch fakeTouchId:pointId AtPoint:CGPointMake(x,y) withTouchPhase:UITouchPhaseEnded];
}




/**
 *
 * 进行查找UILabel的控件位置
 * */


- (void )findCollectionView:(UIView *)view withDic:(NSMutableDictionary *)dic {
    NSArray * subviews  = [view subviews];
    if (!(subviews != nil && ![subviews isKindOfClass:[NSNull class]] && subviews.count != 0))
    {
        return ;
    }

    for( UIView * subView in subviews) {
        if ([subView isMemberOfClass:NSClassFromString(@"UILabel")]) {
            UILabel *label =  (UILabel *)subView;
            [dic setObject:label forKey:label.text];
        }
        [self findCollectionView:subView withDic:dic];
    }
}





/**
 * 获取顶层视图
 * */
- (UIWindow *)NG_LastWindow {
    NSArray *windows = [UIApplication sharedApplication].windows;
    for(UIWindow *window in [windows reverseObjectEnumerator]) {

        if ([window isKindOfClass:[UIWindow class]] &&
                CGRectEqualToRect(window.bounds, [UIScreen mainScreen].bounds))

            return window;
    }

    return [UIApplication sharedApplication].keyWindow;
}

/**
 * array是否为Null
 * */
-(BOOL)NG_ArrayIsBlanding:(NSArray *)array{
    if(array != nil && ![array isKindOfClass:[NSNull class]] && array.count != 0){
        return FALSE;
    }
    return TRUE;
}




@end