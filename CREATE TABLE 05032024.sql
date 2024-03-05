DROP DATABASE tpms;
CREATE DATABASE tpms;
USE tpms;
CREATE TABLE role (
    roleId INT PRIMARY KEY AUTO_INCREMENT,
    roleName VARCHAR(16),
    createdBy INT(4),
    createdOn DATETIME DEFAULT CURRENT_TIMESTAMP,
    updatedBy INT(4),
    updatedOn DATETIME ON UPDATE CURRENT_TIMESTAMP,
    deletedFlag BIT DEFAULT 0
);
    
CREATE TABLE user (
    userId INT PRIMARY KEY AUTO_INCREMENT,
    userFullName VARCHAR(64),
    userName VARCHAR(16),
    password VARCHAR(104),
    roleId INT(4),
    roleName VARCHAR(16),
    phoneNo VARCHAR(16),
    email VARCHAR(96),
    isFirstLogin BIT DEFAULT 0,
    createdBy INT(4),
    createdOn DATETIME DEFAULT CURRENT_TIMESTAMP,
    updatedBy INT(4),
    updatedOn DATETIME ON UPDATE CURRENT_TIMESTAMP,
    deletedFlag BIT DEFAULT 0,
    CONSTRAINT fk_user_roleId FOREIGN KEY (roleId) REFERENCES Role (roleId)
);

CREATE TABLE resource_pool (
    resourceId INT PRIMARY KEY AUTO_INCREMENT,
    resourceName VARCHAR(104),
    resourceCode VARCHAR(16),
    platform VARCHAR(48),
    location VARCHAR(16),
    engagementPlan VARCHAR(24),
    experience VARCHAR(8),
    allocationDate DATETIME,
    phoneNo VARCHAR(16),
    email VARCHAR(96),
    createdBy INT(4),
    createdOn DATETIME DEFAULT CURRENT_TIMESTAMP,
    updatedBy INT(4),
    updatedOn DATETIME ON UPDATE CURRENT_TIMESTAMP,
    status VARCHAR(8),
    deletedFlag BIT DEFAULT 0,
    CONSTRAINT fk_resource_pool_createdBy FOREIGN KEY (createdBy) REFERENCES user (userId),
    CONSTRAINT fk_resource_pool_updatedBy FOREIGN KEY (updatedBy) REFERENCES user (userId)
);

CREATE TABLE resource_pool_history (
    resourceHistoryId INT PRIMARY KEY AUTO_INCREMENT,
    resourceName VARCHAR(104),
    resourceCode VARCHAR(16),
    platform VARCHAR(48),
    location VARCHAR(16),
    engagementPlan VARCHAR(24),
    experience VARCHAR(8),
    allocationDate DATETIME,
    phoneNo VARCHAR(16),
    email VARCHAR(96),
    createdBy INT(4),
    createdOn DATETIME DEFAULT CURRENT_TIMESTAMP,
    updatedBy INT(4),
    updatedOn DATETIME ON UPDATE CURRENT_TIMESTAMP,
    deletedFlag BIT DEFAULT 0,
    CONSTRAINT fk_Resource_pool_history_createdBy FOREIGN KEY (createdBy) REFERENCES user (userId),
    CONSTRAINT fk_Resource_pool_history_updatedBy FOREIGN KEY (updatedBy) REFERENCES user (userId)
);


CREATE TABLE excel_upload_history (
    excelFileId INT PRIMARY KEY AUTO_INCREMENT,
    fileName VARCHAR(96),
    allocationDate DATETIME,
    createdBy INT(4),
    createdOn DATETIME DEFAULT CURRENT_TIMESTAMP,
    updatedBy INT(4),
    updatedOn DATETIME ON UPDATE CURRENT_TIMESTAMP,
    deletedFlag BIT DEFAULT 0,
    CONSTRAINT fk_excel_upload_history_createdBy FOREIGN KEY (createdBy) REFERENCES user (userId),
    CONSTRAINT fk_excel_upload_history_updatedBy FOREIGN KEY (updatedBy) REFERENCES user (userId)
);

CREATE TABLE platforms (
    platformId INT PRIMARY KEY AUTO_INCREMENT,
    platform VARCHAR(24) NOT NULL,
    platformCode VARCHAR(16),
    createdBy INT(4),
    createdOn DATETIME DEFAULT CURRENT_TIMESTAMP,
    updatedBy INT(4),
    updatedOn DATETIME ON UPDATE CURRENT_TIMESTAMP,
    deletedFlag BIT DEFAULT 0,
    CONSTRAINT fk_platforms_createdBy FOREIGN KEY (createdBy) REFERENCES user (userId),
    CONSTRAINT fk_platforms_updatedBy FOREIGN KEY (updatedBy) REFERENCES user (userId)
);

CREATE TABLE activity (
    activityId INT PRIMARY KEY AUTO_INCREMENT,
    activityName VARCHAR(96),
    activityRefNo VARCHAR(48),
    description VARCHAR(248),
    responsPerson1 VARCHAR(96),
    responsPerson2 VARCHAR(96),
    isAsesmentEnable BIT DEFAULT 0,
    createdBy INT(4),
    createdOn DATETIME DEFAULT CURRENT_TIMESTAMP,
    updatedBy INT(4),
    updatedOn DATETIME ON UPDATE CURRENT_TIMESTAMP,
    deletedFlag BIT DEFAULT 0,
    CONSTRAINT fk_activity_createdBy FOREIGN KEY (createdBy) REFERENCES user (userId),
    CONSTRAINT fk_activity_updatedBy FOREIGN KEY (updatedBy) REFERENCES user (userId)
);

CREATE TABLE activity_allocation (
    activityAllocateId INT PRIMARY KEY AUTO_INCREMENT,
    resourceId INT(4),
    platformId INT(4),
    activityDate DATETIME,
    createdBy INT(4),
    createdOn DATETIME DEFAULT CURRENT_TIMESTAMP,
    updatedBy INT(4),
    updatedOn DATETIME ON UPDATE CURRENT_TIMESTAMP,
    deletedFlag BIT DEFAULT 0,
    CONSTRAINT fk_activity_allocation_platformId FOREIGN KEY (platformId) REFERENCES platforms (platformId),
    CONSTRAINT fk_activity_allocation_createdBy FOREIGN KEY (createdBy) REFERENCES user (userId),
    CONSTRAINT fk_activity_allocation_updatedBy FOREIGN KEY (updatedBy) REFERENCES user (userId)
);
      
CREATE TABLE activity_allocation_details (
    activityAllocateDetId INT PRIMARY KEY AUTO_INCREMENT,
    activityAllocateId INT(4),
    activityId INT(4),
    activityFor INT(4),
    fromHours VARCHAR(8),
    toHours VARCHAR(8),
    activityDetails VARCHAR(760),
    createdBy INT(4),
    createdOn DATETIME DEFAULT CURRENT_TIMESTAMP,
    updatedBy INT(4),
    updatedOn DATETIME ON UPDATE CURRENT_TIMESTAMP,
    deletedFlag BIT DEFAULT 0,
    CONSTRAINT fk_activity_allocation_details_activityAllocateId FOREIGN KEY (activityAllocateId)
        REFERENCES activity_allocation (activityAllocateId),
    CONSTRAINT fk_activity_allocation_details_activityId FOREIGN KEY (activityId)
        REFERENCES activity (activityId),
    CONSTRAINT fk_activity_allocation_details_createdBy FOREIGN KEY (createdBy)
        REFERENCES user (userId),
    CONSTRAINT fk_activity_allocation_details_updatedBy FOREIGN KEY (updatedBy)
        REFERENCES user (userId)
);

CREATE TABLE attendance (
    atendanceId INT PRIMARY KEY AUTO_INCREMENT,
    resourceId INT(4),
    activityAllocateId INT(4),
    activityAllocateDetId INT(4),
    atendanceDate DATETIME,
    atendanceFor INT(4),
    isPresent BIT DEFAULT 0,
    createdBy INT(4),
    createdOn DATETIME DEFAULT CURRENT_TIMESTAMP,
    updatedBy INT(4),
    updatedOn DATETIME ON UPDATE CURRENT_TIMESTAMP,
    deletedFlag BIT DEFAULT 0,
    CONSTRAINT fk_attendance_resourceId FOREIGN KEY (resourceId)
        REFERENCES resource_pool (resourceId),
    CONSTRAINT fk_Attendance_ActivityAllocateId FOREIGN KEY (activityAllocateId)
        REFERENCES activity_allocation (activityAllocateId),
    CONSTRAINT fk_attendance_activityAllocateDetId FOREIGN KEY (activityAllocateDetId)
        REFERENCES activity_allocation_details (activityAllocateDetId),
    CONSTRAINT fk_Attendance_createdBy FOREIGN KEY (createdBy)
        REFERENCES user (userId),
    CONSTRAINT fk_ttendance_updatedBy FOREIGN KEY (updatedBy)
        REFERENCES user (userId)
);

CREATE TABLE assessment (
    asesmentId INT PRIMARY KEY AUTO_INCREMENT,
    resourceId INT(4),
    asesmentDate DATETIME,
    activityId INT(4),
    doubleActivityMark DOUBLE(5,2),
    doubleSecuredMark DOUBLE(5,2),
    asesmentHours DOUBLE(5,2),
    remark VARCHAR(248),
    createdBy INT(4),
    createdOn DATETIME DEFAULT CURRENT_TIMESTAMP,
    updatedBy INT(4),
    updatedOn DATETIME ON UPDATE CURRENT_TIMESTAMP,
    deletedFlag BIT DEFAULT 0,
    CONSTRAINT fk_assessment_details_resourceId FOREIGN KEY (resourceId)
        REFERENCES resource_pool (resourceId),
    CONSTRAINT fk_assessment_details_activityId FOREIGN KEY (activityId)
        REFERENCES activity (activityId),
    CONSTRAINT fk_assessment_details_createdBy FOREIGN KEY (createdBy)
        REFERENCES user (userId),
    CONSTRAINT fk_Assessment_details_updatedBy FOREIGN KEY (updatedBy)
        REFERENCES user (userId)
);