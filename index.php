<?php
require_once("settings.php");
require_once("db.php");
require_once("core.php");
require_once("coinhive.php");
require_once("email.php");
require_once("html.php");

// Only ASCII parameters allowed
foreach($_GET as $key => $value) {
        if(validate_ascii($key)==FALSE) die("Non-ASCII parameters disabled");
        if(validate_ascii($value)==FALSE) die("Non-ASCII parameters disabled");
}
foreach($_POST as $key => $value) {
        if(validate_ascii($key)==FALSE) die("Non-ASCII parameters disabled");
        if(validate_ascii($value)==FALSE) die("Non-ASCII parameters disabled");
}


db_connect();

$coinhive_xmr_per_Mhash=get_variable("payoutPer1MHashes");

// Miner link - show only miner for that user
if(isset($_GET['miner'])) {
        $user_uid=stripslashes($_GET['miner']);
        $coinhive_id=get_coinhive_id_by_user_uid($user_uid);
        $miner_form=html_coinhive_frame($coinhive_id);
        echo $miner_form;
        die();
}

$user_uid="";
$logged_in=FALSE;

if(isset($_GET['coin'])) $coin=stripslashes($_GET['coin']);
else $coin='';

$coin_html=html_escape($coin);

// Get session (create new if not exists), user_uid, token
$session=get_session();
$user_uid=get_user_uid_by_session($session);
$token=get_user_token_by_session($session);
//var_dump($session,$user_uid,$token);
if(isset($user_uid) && $user_uid!=0) $logged_in=TRUE;
else $logged_in=FALSE;

// Actions handle
if(isset($_POST['action']) || isset($_GET['action'])) {
        $message='';

        if(isset($_GET['token'])) $received_token=$_GET['token'];
        else $received_token=$_POST['token'];

        if($token!=$received_token) {
                die("Invalid token");
        }

        if(isset($_GET['action'])) $action=$_GET['action'];
        else if(isset($_POST['action'])) $action=$_POST['action'];

        if($action=="register") {
                $login=$_POST['login'];
                $password=$_POST['password'];
                $ref_id=$_POST['ref_id'];
                if($ref_id=='') $ref_id=0;

                $message=user_register_or_login($session,$login,$password,$ref_id);
        } else if($action=="logout") {
                user_logout($session);
        } else if($logged_in==TRUE && $action=="withdraw") {
                $currency_code=$_POST['currency_code'];
                $payout_address=$_POST['payout_address'];

                if(isset($_POST['payment_id'])) $payment_id=$_POST['payment_id'];
                else $payment_id='';

                $message=user_withdraw($session,$user_uid,$currency_code,$payout_address,$payment_id);
        }
        setcookie("message",$message);
        header("Location: ./");
        die();
}

// If message exists, show it to user once
if(isset($_COOKIE['message'])) {
        $message=html_message($_COOKIE['message']);
        setcookie("message","");
} else {
        $message='';
}

if(isset($_GET['json'])) {
        if($logged_in==FALSE) {
                echo html_register_login_info();
        } else {
                // Balance information
                $coinhive_id=get_coinhive_id_by_user_uid($user_uid);
                $old_balance_data=get_user_balance_detail($user_uid);
                $coinhive_balance=coinhive_get_user_balance($coinhive_id);
                update_user_mined_balance($user_uid,$coinhive_balance);
                $new_balance_data=get_user_balance_detail($user_uid);

                echo html_balance_detail($user_uid,$old_balance_data,$new_balance_data);

                // Common information
                $user_hashes=$new_balance_data['balance'];
                if($coin=='') {
                        echo html_select_your_coin($user_hashes);
                } else {
                        echo html_results_in_coin($user_uid,$user_hashes,$coin);
                }

                // Achievements
                echo html_achievements_section($user_uid);

                // User links
                echo html_links_section($user_uid);

                // User payouts
                echo html_payouts_section($user_uid);

        }

        die();
}


echo html_page_begin($pool_name);

if($message) echo $message;

// If logged in, show balance info
if($logged_in) {
        // Welcome message and logout link
        echo html_welcome_logout_form($user_uid);

        // Coinhive miner
        $coinhive_id=get_coinhive_id_by_user_uid($user_uid);
        echo html_coinhive_frame($coinhive_id);

        // Balance information
        echo html_balance_big($user_uid);
        echo html_mininig_info_block();

// If not logged in, show common information
} else {
        echo html_register_login_info();
}

// End of page, script and footer
echo html_page_end();

?>
