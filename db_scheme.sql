SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";

CREATE TABLE IF NOT EXISTS `currency` (
  `uid` int(11) NOT NULL AUTO_INCREMENT,
  `currency_code` varchar(100) COLLATE utf8_unicode_ci NOT NULL,
  `currency_name` varchar(100) COLLATE utf8_unicode_ci NOT NULL,
  `enabled` int(11) NOT NULL DEFAULT '1',
  `payout_fee` double NOT NULL,
  `project_fee` double NOT NULL DEFAULT '0',
  `api_url` text COLLATE utf8_unicode_ci NOT NULL,
  `url_wallet` varchar(100) COLLATE utf8_unicode_ci NOT NULL,
  `url_tx` varchar(100) COLLATE utf8_unicode_ci NOT NULL,
  `img_url` text COLLATE utf8_unicode_ci NOT NULL,
  `payment_id_field` int(11) NOT NULL DEFAULT '0',
  `rate_per_mhash` double NOT NULL DEFAULT '0',
  `user_withdraw_note` text COLLATE utf8_unicode_ci NOT NULL,
  `admin_withdraw_note` text COLLATE utf8_unicode_ci NOT NULL,
  `timestamp` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`uid`),
  UNIQUE KEY `currency_code` (`currency_code`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci AUTO_INCREMENT=110 ;

CREATE TABLE IF NOT EXISTS `email` (
  `uid` int(11) NOT NULL AUTO_INCREMENT,
  `to` varchar(100) COLLATE utf8_unicode_ci NOT NULL,
  `subject` text COLLATE utf8_unicode_ci NOT NULL,
  `message` text COLLATE utf8_unicode_ci NOT NULL,
  `is_sent` int(11) NOT NULL DEFAULT '0',
  `is_success` int(11) NOT NULL DEFAULT '0',
  `timestamp` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`uid`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci AUTO_INCREMENT=46 ;

CREATE TABLE IF NOT EXISTS `log` (
  `uid` int(11) NOT NULL AUTO_INCREMENT,
  `message` text COLLATE utf8_unicode_ci NOT NULL,
  `timestamp` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`uid`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci AUTO_INCREMENT=256 ;

CREATE TABLE IF NOT EXISTS `payouts` (
  `uid` int(11) NOT NULL AUTO_INCREMENT,
  `session` varchar(100) COLLATE utf8_unicode_ci NOT NULL,
  `user_uid` int(11) NOT NULL,
  `currency_code` varchar(100) COLLATE utf8_unicode_ci NOT NULL,
  `address` varchar(100) COLLATE utf8_unicode_ci NOT NULL,
  `payment_id` varchar(100) COLLATE utf8_unicode_ci NOT NULL,
  `hashes` int(11) NOT NULL,
  `rate_per_mhash` double NOT NULL,
  `amount` double NOT NULL,
  `payout_fee` double NOT NULL,
  `project_fee` double NOT NULL,
  `total` double NOT NULL,
  `tx_id` varchar(100) COLLATE utf8_unicode_ci DEFAULT NULL,
  `timestamp` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`uid`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci AUTO_INCREMENT=50 ;

CREATE TABLE IF NOT EXISTS `sessions` (
  `uid` int(11) NOT NULL AUTO_INCREMENT,
  `session` varchar(100) COLLATE utf8_unicode_ci NOT NULL,
  `token` varchar(100) COLLATE utf8_unicode_ci NOT NULL,
  `user_uid` int(11) DEFAULT NULL,
  `timestamp` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`uid`),
  UNIQUE KEY `session` (`session`),
  UNIQUE KEY `token` (`token`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci AUTO_INCREMENT=461 ;

CREATE TABLE IF NOT EXISTS `users` (
  `uid` int(11) NOT NULL AUTO_INCREMENT,
  `username` varchar(100) COLLATE utf8_unicode_ci NOT NULL,
  `password_hash` varchar(100) COLLATE utf8_unicode_ci NOT NULL,
  `coinhive_id` varchar(50) COLLATE utf8_unicode_ci DEFAULT NULL,
  `mined` bigint(20) NOT NULL DEFAULT '0',
  `withdrawn` bigint(20) NOT NULL DEFAULT '0',
  `bonus` bigint(20) NOT NULL,
  `cooldown` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `ref_id` int(11) DEFAULT NULL,
  `timestamp` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`uid`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci AUTO_INCREMENT=41 ;

CREATE TABLE IF NOT EXISTS `variables` (
  `uid` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(100) COLLATE utf8_unicode_ci NOT NULL,
  `value` varchar(100) COLLATE utf8_unicode_ci NOT NULL,
  `timestamp` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`uid`),
  UNIQUE KEY `name` (`name`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci AUTO_INCREMENT=2 ;
