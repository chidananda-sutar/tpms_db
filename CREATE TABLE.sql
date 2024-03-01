CREATE DATABASE tpms;
USE tpms;
#1
CREATE TABLE tbl_mst_role
 (
    intRoleId  INT PRIMARY KEY AUTO_INCREMENT,
    vchRoleName varchar(16),
    intCreatedBy int(4),
    dtmCreatedOn DATETIME DEFAULT CURRENT_TIMESTAMP,
    intUpdatedBy int(4),
    dtmUpdatedOn DATETIME ON UPDATE CURRENT_TIMESTAMP ,
    bitDeletedFlag bit DEFAULT 0
	);
    
    #2
CREATE TABLE  tbl_user
 (
    intUserId  INT PRIMARY KEY AUTO_INCREMENT,
    vchUserFullName varchar(64),
    vchUserName varchar(16),
    vchPassword varchar(104),
    intRoleId int(4),
    vchRoleName varchar(16),
    vchPhoneNo VARCHAR (16),
    vchEmail VARCHAR(96),
	bitFirstLogin bit DEFAULT 0,
    intCreatedBy int(4),
    dtmCreatedOn DATETIME DEFAULT CURRENT_TIMESTAMP,
    intUpdatedBy int(4),
    dtmUpdatedOn DATETIME ON UPDATE CURRENT_TIMESTAMP,
    bitDeletedFlag bit DEFAULT 0,
	CONSTRAINT fk_tbl_user_intRoleId FOREIGN KEY (intRoleId) REFERENCES  tbl_mst_role(intRoleId)
);

#3
CREATE TABLE  tbl_resource_pool
 (
    intResourceId  INT PRIMARY KEY AUTO_INCREMENT,
    vchResourceName varchar(104),
    vchResourceCode varchar(16),
    vchPlatform varchar(48),
    vchLocation varchar(16),
    vchEngagementPlan varchar(24),
    vchExperience varchar(8),
    dtmAllocationDate DATETIME,
    vchPhoneNo varchar(16),
    vchEmail varchar(96),
    intCreatedBy int(4),
    dtmCreatedOn DATETIME DEFAULT CURRENT_TIMESTAMP,
    intUpdatedBy int(4),
    dtmUpdatedOn DATETIME ON UPDATE CURRENT_TIMESTAMP,
    vchStatus varchar(8),
    bitDeletedFlag bit DEFAULT 0,
    CONSTRAINT fk_tbl_resource_pool_intCreatedBy FOREIGN KEY (intCreatedBy) REFERENCES  tbl_user(intUserId),
    CONSTRAINT fk_tbl_resource_pool_intUpdatedBy FOREIGN KEY (intUpdatedBy) REFERENCES  tbl_user(intUserId)
);

#4
CREATE TABLE   tbl_resource_pool_history
 (
    intResourceHistoryId  INT PRIMARY KEY AUTO_INCREMENT,
    vchResourceName varchar(104),
    vchResourceCode varchar(16),
    vchPlatform varchar(48),
    vchLocation varchar(16),
    vchEngagementPlan varchar(24),
    vchExperience varchar(8),
    dtmAllocationDate DATETIME,
    vchPhoneNo varchar(16),
    vchEmail varchar(96),
    intCreatedBy int(4),
    dtmCreatedOn DATETIME DEFAULT CURRENT_TIMESTAMP,
    intUpdatedBy int(4),
    dtmUpdatedOn DATETIME ON UPDATE CURRENT_TIMESTAMP,
    bitDeletedFlag bit DEFAULT 0,
    CONSTRAINT fk_tbl_resource_pool_history_intCreatedBy FOREIGN KEY (intCreatedBy) REFERENCES  tbl_user(intUserId),
    CONSTRAINT fk_tbl_resource_pool_history_intUpdatedBy FOREIGN KEY (intUpdatedBy) REFERENCES  tbl_user(intUserId)
);

#5
  CREATE TABLE tbl_resource_upload_history
 (
    intResourceFileId  INT PRIMARY KEY AUTO_INCREMENT,
    vchFileName varchar(96),
    dtmAllocationDate DATETIME,
    intCreatedBy int(4),
    dtmCreatedOn DATETIME DEFAULT CURRENT_TIMESTAMP,
    intUpdatedBy int(4),
    dtmUpdatedOn DATETIME ON UPDATE CURRENT_TIMESTAMP,
    bitDeletedFlag bit DEFAULT 0,
    CONSTRAINT fk_tbl_resource_upload_history_intCreatedBy FOREIGN KEY (intCreatedBy) REFERENCES  tbl_user(intUserId),
    CONSTRAINT fk_tbl_resource_upload_history_intUpdatedBy FOREIGN KEY (intUpdatedBy) REFERENCES  tbl_user(intUserId)
);

#6
CREATE TABLE tbl_mst_platforms
 (
    intPlatformId  INT PRIMARY KEY AUTO_INCREMENT,
    vchPlatform varchar(24) not null,
    vchPlatformCode varchar(16),
    intCreatedBy int(4),
    dtmCreatedOn DATETIME DEFAULT CURRENT_TIMESTAMP,
    intUpdatedBy int(4),
    dtmUpdatedOn DATETIME ON UPDATE CURRENT_TIMESTAMP,
    bitDeletedFlag bit DEFAULT 0,
    CONSTRAINT fk_tbl_mst_platforms_intCreatedBy FOREIGN KEY (intCreatedBy) REFERENCES  tbl_user(intUserId),
    CONSTRAINT fk_tbl_mst_platforms_intUpdatedBy FOREIGN KEY (intUpdatedBy) REFERENCES  tbl_user(intUserId)
);

#7
CREATE TABLE tbl_activity
 (
    intActivityId  INT PRIMARY KEY AUTO_INCREMENT,
    vchActivityName varchar(96),
    vchActivityRefNo  varchar(48),
	vchDescription varchar(248),
    vchResponsPerson1 varchar(96),
    vchResponsPerson2    varchar(96),
	isAsesmentEnable bit DEFAULT 0,
    intCreatedBy int(4),																																																												
    dtmCreatedOn DATETIME DEFAULT CURRENT_TIMESTAMP,
    intUpdatedBy int(4),
    dtmUpdatedOn DATETIME ON UPDATE CURRENT_TIMESTAMP,
    bitDeletedFlag bit DEFAULT 0,
    CONSTRAINT fk_tbl_activity_intCreatedBy FOREIGN KEY (intCreatedBy) REFERENCES  tbl_user(intUserId),
    CONSTRAINT fk_tbl_activity_intUpdatedBy FOREIGN KEY (intUpdatedBy) REFERENCES  tbl_user(intUserId));

#8
CREATE TABLE tbl_activity_allocation
 (
    intActivityAllocateId  INT PRIMARY KEY AUTO_INCREMENT,
    intResourceId int(4),
	intPlatformId int(4),
	dtmActivityDate DATETIME,
    intCreatedBy int(4),
    dtmCreatedOn DATETIME DEFAULT CURRENT_TIMESTAMP,
    intUpdatedBy int(4),
    dtmUpdatedOn DATETIME ON UPDATE CURRENT_TIMESTAMP,
    bitDeletedFlag bit DEFAULT 0,
    CONSTRAINT fk_tbl_activity_allocation_intPlatformId FOREIGN KEY (intPlatformId) REFERENCES  tbl_mst_platforms(intPlatformId),
    CONSTRAINT fk_tbl_activity_allocation_intCreatedBy FOREIGN KEY (intCreatedBy) REFERENCES  tbl_user(intUserId),
    CONSTRAINT fk_tbl_activity_allocation_intUpdatedBy FOREIGN KEY (intUpdatedBy) REFERENCES  tbl_user(intUserId));
      
    #9
CREATE TABLE tbl_activity_allocation_details

 (
    intActivityAllocateDetId  INT PRIMARY KEY AUTO_INCREMENT,
    intActivityAllocateId int(4),
    intActivityId int(4),
	intActivityFor int(4),
    vchFromHours varchar(8),
    vchToHours varchar(8),
    txtActivityDetails varchar(760),
	intCreatedBy int(4),
    dtmCreatedOn DATETIME DEFAULT CURRENT_TIMESTAMP,
    intUpdatedBy int(4),
    dtmUpdatedOn DATETIME ON UPDATE CURRENT_TIMESTAMP,
    bitDeletedFlag bit DEFAULT 0,
	CONSTRAINT fk_tbl_activity_allocation_details_intActivityAllocateId FOREIGN KEY (intActivityAllocateId) REFERENCES tbl_activity_allocation(intActivityAllocateId),
	CONSTRAINT fk_tbl_activity_allocation_details_intActivityId FOREIGN KEY (intActivityId) REFERENCES  tbl_activity(intActivityId),
    CONSTRAINT fk_tbl_activity_allocation_details_intCreatedBy FOREIGN KEY (intCreatedBy) REFERENCES  tbl_user(intUserId),
    CONSTRAINT fk_tbl_activity_allocation_details_intUpdatedBy FOREIGN KEY (intUpdatedBy) REFERENCES  tbl_user(intUserId)
    );

#10
CREATE TABLE tbl_attendance
 (
    intAtendanceId   INT PRIMARY KEY AUTO_INCREMENT,
    intResourceId int(4),
    intActivityAllocateId int(4),
    intActivityAllocateDetId int(4),
    dtmAtendanceDate DATETIME,
	intAtendanceFor int(4),
    chrPresent char(5),
    intCreatedBy int(4),
    dtmCreatedOn DATETIME DEFAULT CURRENT_TIMESTAMP,
    intUpdatedBy int(4),
    dtmUpdatedOn DATETIME ON UPDATE CURRENT_TIMESTAMP,
    bitDeletedFlag bit DEFAULT 0,
	CONSTRAINT fk_tbl_attendance_intResourceId FOREIGN KEY (intResourceId) REFERENCES  tbl_resource_pool(intResourceId),
	CONSTRAINT fk_tbl_attendance_intActivityAllocateId FOREIGN KEY (intActivityAllocateId) REFERENCES tbl_activity_allocation(intActivityAllocateId),
	CONSTRAINT fk_tbl_attendance_intActivityAllocateDetId FOREIGN KEY (intActivityAllocateDetId) REFERENCES tbl_activity_allocation_details(intActivityAllocateDetId),
    CONSTRAINT fk_tbl_attendance_intCreatedBy FOREIGN KEY (intCreatedBy) REFERENCES  tbl_user(intUserId),
    CONSTRAINT fk_tbl_attendance_intUpdatedBy FOREIGN KEY (intUpdatedBy) REFERENCES  tbl_user(intUserId));

#11
CREATE TABLE tbl_assessment

 (
    intAsesmentId INT PRIMARY KEY AUTO_INCREMENT,
    intResourceId  int(4),
	dtmAsesmentDate DATETIME,
    intActivityId int(4),
    doubleActivityMark  double(5,2),
    doubleSecuredMark double(5,2),
    vchAsesmentHours varchar(8),
    vchRemark varchar(248),
    intCreatedBy int(4),
    dtmCreatedOn DATETIME DEFAULT CURRENT_TIMESTAMP,
    intUpdatedBy int(4),
    dtmUpdatedOn DATETIME ON UPDATE CURRENT_TIMESTAMP,
    bitDeletedFlag bit DEFAULT 0,
    CONSTRAINT fk_tbl_assessment_details_intResourceId FOREIGN KEY (intResourceId) REFERENCES tbl_resource_pool(intResourceId),
    CONSTRAINT fk_tbl_assessment_details_intActivityId FOREIGN KEY (intActivityId) REFERENCES tbl_activity(intActivityId),
    CONSTRAINT fk_tbl_assessment_details_intCreatedBy FOREIGN KEY (intCreatedBy) REFERENCES  tbl_user(intUserId),
    CONSTRAINT fk_tbl_assessment_details_intUpdatedBy FOREIGN KEY (intUpdatedBy) REFERENCES  tbl_user(intUserId)
);



