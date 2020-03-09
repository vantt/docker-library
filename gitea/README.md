Migrating to Gitea 1.11.1

# For new install need Create DB without register user when install


CREATE DATABASE `gitea` DEFAULT CHARACTER SET utf8 COLLATE utf8_general_ci;

GRANT ALL PRIVILEGES ON gitea.* TO 'root'@'%' IDENTIFIED BY 'root';

FLUSH PRIVILEGES;

gogs_data container
/data/gogs_data/gogs/git/gogs-repositories/
mv /data/gitea_data/git/repositories/ /data/gitea_data/git/bk-repositories/ 
mv /data/gitea_data/git/gogs-repositories/ /data/gitea_data/git/repositories/ 



db container
----------------------
mysqldump -uroot -proot -h localhost gogs > gogs_20200220.sql
mysqldump -uroot -proot -h localhost gogs user > ap_gg_user.sql
mysqldump -uroot -proot -h localhost gogs repository > ap_gg_repository.sql
mysqldump --no-create-info -uroot -proot -h localhost gogs team > ap_gg_team.sql
mysqldump --no-create-info -uroot -proot -h localhost gogs team_repo > ap_gg_team_repo.sql
mysqldump --no-create-info -uroot -proot -h localhost gogs team_user > ap_gg_team_user.sql
mysqldump -uroot -proot -h localhost gogs org_user > ap_gg_org_user.sql
mysqldump -uroot -proot -h localhost gogs webhook > ap_gg_webhook.sql
mysqldump -uroot -proot -h localhost gogs public_key > ap_gg_pubkey.sql
mysqldump -uroot -proot -h localhost gogs release > ap_gg_release.sql

Edit Data:

docker cp docker_db_1:/data/ap_gg_user.sql .
docker cp docker_db_1:/data/ap_gg_org_user.sql .
docker cp docker_db_1:/data/ap_gg_repository.sql .
docker cp docker_db_1:/data/ap_gg_webhook.sql .
docker cp docker_db_1:/data/ap_gg_pubkey.sql .
docker cp docker_db_1:/data/ap_gg_release.sql .
docker cp docker_db_1:/data/ap_gg_team.sql .
user, bo user 1 -> Import nguyen con
repository is_bare->is_empty

user-> user_ap
repository -> repository_ap
org_user -> org_user_ap
webhook -> webhook_ap
pubkey -> pubkey_ap
release->release_ap

vi ap_gg_user.sql
vi ap_gg_org_user.sql
vi ap_gg_repository.sql
vi ap_gg_webhook.sql
vi ap_gg_pubkey.sql
vi ap_gg_release.sql

rm ap_gg_user.sql
rm ap_gg_org_user.sql
rm ap_gg_repository.sql
rm ap_gg_webhook.sql
rm ap_gg_pubkey.sql
rm ap_gg_release.sql

docker cp ap_gg_user.sql docker_db_1:/data/
docker cp ap_gg_org_user.sql docker_db_1:/data/
docker cp ap_gg_repository.sql docker_db_1:/data/ 
docker cp ap_gg_webhook.sql docker_db_1:/data/ 
docker cp ap_gg_pubkey.sql docker_db_1:/data/ 
docker cp repo_unit.sql docker_db_1:/data/ 
docker cp ap_gg_release.sql docker_db_1:/data/ 

Import to  Gitea: 

mysql -uroot -proot -h localhost gitea < ap_gg_user.sql
mysql -uroot -proot -h localhost gitea < ap_gg_repository.sql
mysql -uroot -proot -h localhost gitea < ap_gg_team.sql
mysql -uroot -proot -h localhost gitea < ap_gg_team_repo.sql
mysql -uroot -proot -h localhost gitea < ap_gg_team_user.sql
mysql -uroot -proot -h localhost gitea < ap_gg_org_user.sql
mysql -uroot -proot -h localhost gitea < ap_gg_webhook.sql
mysql -uroot -proot -h localhost gitea < ap_gg_pubkey.sql
mysql -uroot -proot -h localhost gitea < repo_unit.sql

mysql -uroot -proot -h localhost gitea < ap_gg_release.sql
truncate repository gitea

--- user 

INSERT user(`id`,`lower_name`,`name`,`full_name`,`email`,`passwd`,`login_type`,`login_source`,`login_name`,`type`,`location`,`website`,`rands`,`salt`,`description`,`created_unix`,`updated_unix`,`last_repo_visibility`,`max_repo_creation`,`is_active`,`is_admin`,`allow_git_hook`,`allow_import_local`,`prohibit_login`,`avatar`,`avatar_email`,`use_custom_avatar`,`num_followers`,`num_following`,`num_stars`,`num_repos`,`num_teams`,`num_members`) SELECT `id`,`lower_name`,`name`,`full_name`,`email`,`passwd`,`login_type`,`login_source`,`login_name`,`type`,`location`,`website`,`rands`,`salt`,`description`,`created_unix`,`updated_unix`,`last_repo_visibility`,`max_repo_creation`,`is_active`,`is_admin`,`allow_git_hook`,`allow_import_local`,`prohibit_login`,`avatar`,`avatar_email`,`use_custom_avatar`,`num_followers`,`num_following`,`num_stars`,`num_repos`,`num_teams`,`num_members` FROM user_ap;

-- truncate repository

INSERT repository(`id`,`owner_id`,`lower_name`,`name`,`description`,`website`,`default_branch`,`num_watches`,`num_stars`,`num_forks`,`num_issues`,`num_closed_issues`,`num_pulls`,`num_closed_pulls`,`num_milestones`,`num_closed_milestones`,`is_private`,`is_empty`,`is_mirror`,`is_fork`,`fork_id`,`created_unix`,`updated_unix`) SELECT `id`,`owner_id`,`lower_name`,`name`,`description`,`website`,`default_branch`,`num_watches`,`num_stars`,`num_forks`,`num_issues`,`num_closed_issues`,`num_pulls`,`num_closed_pulls`,`num_milestones`,`num_closed_milestones`,`is_private`,`is_empty`,`is_mirror`,`is_fork`,`fork_id`,`created_unix`,`updated_unix` FROM repository_ap;

INSERT org_user(`id`, `uid`, `org_id`, `is_public`) SELECT `id`, `uid`, `org_id`, `is_public` FROM org_user_ap;

INSERT webhook(`id`,`repo_id`,`org_id`,`url`,`content_type`,`secret`,`events`,`is_ssl`,`is_active`, `hook_task_type`,`meta`,`last_status`, `created_unix`,`updated_unix`) SELECT `id`,`repo_id`,`org_id`,`url`,`content_type`,`secret`,`events`,`is_ssl`,`is_active`, `hook_task_type`,`meta`,`last_status`, `created_unix`,`updated_unix` FROM webhook_ap;

INSERT public_key(`id`, `owner_id`, `name`, `fingerprint`, `content`, `mode`, `type`, `created_unix`, `updated_unix`) SELECT `id`, `owner_id`, `name`, `fingerprint`, `content`, `mode`, `type`, `created_unix`, `updated_unix` from public_key_ap;

INSERT gitea.release(`id`,`repo_id`,`publisher_id`,`tag_name`,`lower_tag_name`,`target`,`title`,`sha1`,`num_commits`,`note`,`is_draft`,`is_prerelease`,`created_unix`) SELECT `id`,`repo_id`,`publisher_id`,`tag_name`,`lower_tag_name`,`target`,`title`,`sha1`,`num_commits`,`note`,`is_draft`,`is_prerelease`,`created_unix` FROM release_ap;

CREATE PROCEDURE add_repo_unit()
BEGIN
    DECLARE i int DEFAULT 1;
    WHILE i <= 717 DO
    	INSERT INTO repo_unit (repo_id, type, config, created_unix) VALUES (i, 1, '', unix_timestamp(now()));
    	INSERT INTO repo_unit (repo_id, type, config, created_unix) VALUES (i, 2, '{"EnableTimetracker":true,"AllowOnlyContributorsToTrackTime":true,"EnableDependencies":true}', unix_timestamp(now()));
        INSERT INTO repo_unit (repo_id, type, config, created_unix) VALUES (i, 3, '{"IgnoreWhitespaceConflicts":false,"AllowMerge":true,"AllowRebase":true,"AllowRebaseMerge":true,"AllowSquash":true}', unix_timestamp(now())); 
        INSERT INTO repo_unit (repo_id, type, config, created_unix) VALUES (i, 4,'',unix_timestamp(now()));
        INSERT INTO repo_unit (repo_id, type, config, created_unix) VALUES (i, 5,'',unix_timestamp(now()));
        SET i = i + 1;
    END WHILE;
END;

CALL add_repo_unit()
DROP PROCEDURE add_repo_unit()