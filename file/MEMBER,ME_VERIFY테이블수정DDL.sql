
ALTER TABLE `member` 
ADD COLUMN `me_temppw` int default 0,
ADD COLUMN `me_verify` int default 0;

DROP TABLE IF EXISTS `ME_VERIFY`;
CREATE TABLE `me_verify` (
   `mv_me_id` varchar(50) NOT NULL,
   `mv_code` varchar(6) NOT NULL,
   `mv_exptime` datetime NOT NULL,
   `mv_createtime` datetime NOT NULL,
   PRIMARY KEY (`mv_me_id`),
   CONSTRAINT `FK_member_TO_me_verify_1` FOREIGN KEY (`mv_me_id`) REFERENCES `member` (`me_id`)
 ) 
 
 