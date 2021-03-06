----
-- Copyright (c) 2012-2017 Apple Inc. All rights reserved.
--
-- Licensed under the Apache License, Version 2.0 (the "License");
-- you may not use this file except in compliance with the License.
-- You may obtain a copy of the License at
--
-- http://www.apache.org/licenses/LICENSE-2.0
--
-- Unless required by applicable law or agreed to in writing, software
-- distributed under the License is distributed on an "AS IS" BASIS,
-- WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
-- See the License for the specific language governing permissions and
-- limitations under the License.
----

---------------------------------------------------
-- Upgrade database schema from VERSION 46 to 47 --
---------------------------------------------------



create table GROUP_DELEGATE_CHANGES_WORK (
  WORK_ID                       integer      primary key default nextval('WORKITEM_SEQ') not null, -- implicit index
  JOB_ID                        integer      references JOB not null,
  DELEGATOR_UID                 varchar(255) not null,
  READ_DELEGATE_UID             varchar(255) not null,
  WRITE_DELEGATE_UID            varchar(255) not null
);

create index GROUP_DELEGATE_CHANGES_WORK_JOB_ID on
  GROUP_DELEGATE_CHANGES_WORK(JOB_ID);


-- Add "unique" to GROUPS.GROUP_UID
drop index GROUPS_GROUP_UID;
alter table GROUPS add unique (GROUP_UID);


-- update the version
update CALENDARSERVER set VALUE = '47' where NAME = 'VERSION';
