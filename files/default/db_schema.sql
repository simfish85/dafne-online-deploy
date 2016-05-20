DROP TABLE IF EXISTS carb_counts;

CREATE TABLE carb_counts (
  id int(11) NOT NULL AUTO_INCREMENT,
  item_description varchar(255) NOT NULL,
  category varchar(255) DEFAULT NULL,
  portion varchar(255) DEFAULT NULL,
  weight varchar(255) NOT NULL,
  weight_type varchar(255) DEFAULT NULL,
  CP varchar(255) NOT NULL,
  carb varchar(255) NOT NULL,
  username varchar(255) NOT NULL,
  approved int(11) NOT NULL,
  country varchar(3) DEFAULT NULL,
  PRIMARY KEY (id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;


--
-- Table structure for table carb_sites
--

DROP TABLE IF EXISTS carb_sites;


CREATE TABLE carb_sites (
  id int(11) NOT NULL AUTO_INCREMENT,
  site_description varchar(255) NOT NULL,
  site_url varchar(255) NOT NULL,
  username varchar(255) NOT NULL,
  comments varchar(2048) DEFAULT NULL,
  PRIMARY KEY (id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;


--
-- Table structure for table centre_codes
--

DROP TABLE IF EXISTS centre_codes;


CREATE TABLE centre_codes (
  id int(11) NOT NULL AUTO_INCREMENT,
  code varchar(255) DEFAULT NULL,
  created_at datetime DEFAULT NULL,
  dafne_centre_id int(11) NOT NULL,
  PRIMARY KEY (id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;


--
-- Table structure for table dafne_centres
--

DROP TABLE IF EXISTS dafne_centres;


CREATE TABLE dafne_centres (
  id int(11) NOT NULL AUTO_INCREMENT,
  location varchar(255) DEFAULT NULL,
  centre_code varchar(255) DEFAULT NULL,
  created_at datetime DEFAULT NULL,
  updated_at datetime DEFAULT NULL,
  region varchar(255) NOT NULL,
  disabled int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;


--
-- Table structure for table diary_entries
--

DROP TABLE IF EXISTS diary_entries;


CREATE TABLE diary_entries (
  id int(11) NOT NULL AUTO_INCREMENT,
  user_id int(11) DEFAULT NULL,
  time datetime DEFAULT NULL,
  cps varchar(15) DEFAULT NULL,
  bg decimal(10,2) DEFAULT NULL,
  qa varchar(15) DEFAULT NULL,
  bi varchar(10) DEFAULT NULL,
  comments varchar(255) DEFAULT NULL,
  diary_entry_type_id int(11) DEFAULT NULL,
  ratio varchar(10) DEFAULT NULL,
  injection_site_id int(11) DEFAULT NULL,
  created_at datetime NOT NULL,
  updated_at datetime NOT NULL,
  ketones varchar(15) DEFAULT NULL,
  bi_injection_site_id int(11) DEFAULT NULL,
  PRIMARY KEY (id),
  KEY userOnly (user_id) USING BTREE,
  KEY userTime (user_id,time) USING BTREE,
  KEY userBGTime (user_id,time,bg) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;


--
-- Table structure for table diary_entry_types
--

DROP TABLE IF EXISTS diary_entry_types;


CREATE TABLE diary_entry_types (
  id int(11) NOT NULL AUTO_INCREMENT,
  long_desc varchar(255) DEFAULT NULL,
  short_desc varchar(255) DEFAULT NULL,
  target_min decimal(10,2) DEFAULT NULL,
  target_max decimal(10,2) DEFAULT NULL,
  PRIMARY KEY (id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;


--
-- Table structure for table diary_shares
--

DROP TABLE IF EXISTS diary_shares;


CREATE TABLE diary_shares (
  id int(11) NOT NULL AUTO_INCREMENT,
  user_id int(11) DEFAULT NULL,
  viewer_id int(11) DEFAULT NULL,
  PRIMARY KEY (id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;


--
-- Table structure for table diary_targets
--

DROP TABLE IF EXISTS diary_targets;


CREATE TABLE diary_targets (
  id int(11) NOT NULL AUTO_INCREMENT,
  user_id int(11) DEFAULT NULL,
  diary_entry_type_id int(11) DEFAULT NULL,
  target_min decimal(10,2) DEFAULT NULL,
  target_max decimal(10,2) DEFAULT NULL,
  PRIMARY KEY (id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;


--
-- Table structure for table forums
--

DROP TABLE IF EXISTS forums;


CREATE TABLE forums (
  id int(11) NOT NULL AUTO_INCREMENT,
  topics_count int(11) DEFAULT NULL,
  posts_count int(11) DEFAULT NULL,
  position int(11) DEFAULT NULL,
  name varchar(255) DEFAULT NULL,
  description varchar(255) DEFAULT NULL,
  description_html text,
  created_at datetime DEFAULT NULL,
  updated_at datetime DEFAULT NULL,
  userlevel smallint(5) unsigned DEFAULT NULL,
  dafne_centre_id int(11) DEFAULT NULL,
  PRIMARY KEY (id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;


--
-- Table structure for table hbook_topics
--

DROP TABLE IF EXISTS hbook_topics;


CREATE TABLE hbook_topics (
  id int(11) NOT NULL AUTO_INCREMENT,
  parent_id int(11) DEFAULT NULL,
  prev_id int(11) DEFAULT NULL,
  next_id int(11) DEFAULT NULL,
  country varchar(3) NOT NULL,
  title varchar(255) DEFAULT NULL,
  body text,
  views int(11) DEFAULT NULL,
  created_at datetime DEFAULT NULL,
  updated_at datetime DEFAULT NULL,
  PRIMARY KEY (id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;


--
-- Table structure for table logged_exceptions
--

DROP TABLE IF EXISTS logged_exceptions;


CREATE TABLE logged_exceptions (
  id int(11) NOT NULL AUTO_INCREMENT,
  exception_class varchar(255) DEFAULT NULL,
  controller_name varchar(255) DEFAULT NULL,
  action_name varchar(255) DEFAULT NULL,
  message varchar(255) DEFAULT NULL,
  backtrace text,
  environment text,
  request text,
  created_at datetime DEFAULT NULL,
  PRIMARY KEY (id)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


--
-- Table structure for table moderatorships
--

DROP TABLE IF EXISTS moderatorships;


CREATE TABLE moderatorships (
  id int(11) NOT NULL AUTO_INCREMENT,
  forum_id int(11) DEFAULT NULL,
  user_id int(11) DEFAULT NULL,
  created_at datetime DEFAULT NULL,
  updated_at datetime DEFAULT NULL,
  PRIMARY KEY (id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;


--
-- Table structure for table monitorships
--

DROP TABLE IF EXISTS monitorships;


CREATE TABLE monitorships (
  id int(11) NOT NULL AUTO_INCREMENT,
  topic_id int(11) DEFAULT NULL,
  user_id int(11) DEFAULT NULL,
  active int(11) DEFAULT '1',
  created_at datetime DEFAULT NULL,
  updated_at datetime DEFAULT NULL,
  PRIMARY KEY (id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;


--
-- Table structure for table monitorships_sweepers
--

DROP TABLE IF EXISTS monitorships_sweepers;


CREATE TABLE monitorships_sweepers (
  id int(11) NOT NULL AUTO_INCREMENT,
  created_at datetime DEFAULT NULL,
  updated_at datetime DEFAULT NULL,
  PRIMARY KEY (id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;


--
-- Table structure for table news_items
--

DROP TABLE IF EXISTS news_items;


CREATE TABLE news_items (
  id int(11) NOT NULL AUTO_INCREMENT,
  headline varchar(255) DEFAULT NULL,
  content text,
  user_id int(11) DEFAULT NULL,
  created_at datetime DEFAULT NULL,
  updated_at datetime DEFAULT NULL,
  PRIMARY KEY (id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;


--
-- Table structure for table pm_messages
--

DROP TABLE IF EXISTS pm_messages;


CREATE TABLE pm_messages (
  id int(11) NOT NULL AUTO_INCREMENT,
  sender_id int(11) DEFAULT NULL,
  body text COLLATE utf8_unicode_ci,
  `read` tinyint(1) DEFAULT NULL,
  created_at datetime DEFAULT NULL,
  updated_at datetime DEFAULT NULL,
  pm_thread_id int(11) DEFAULT NULL,
  PRIMARY KEY (id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;


--
-- Table structure for table pm_threads
--

DROP TABLE IF EXISTS pm_threads;


CREATE TABLE pm_threads (
  id int(11) NOT NULL AUTO_INCREMENT,
  title varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  thread_status int(11) DEFAULT NULL,
  sender_id int(11) DEFAULT NULL,
  receiver_id int(11) DEFAULT NULL,
  created_at datetime DEFAULT NULL,
  updated_at datetime DEFAULT NULL,
  PRIMARY KEY (id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;


--
-- Table structure for table poll_results
--

DROP TABLE IF EXISTS poll_results;


CREATE TABLE poll_results (
  user_id int(11) DEFAULT NULL,
  option_one_rank int(11) DEFAULT NULL,
  option_two_rank int(11) DEFAULT NULL,
  option_three_rank int(11) DEFAULT NULL,
  option_four_rank int(11) DEFAULT NULL,
  other_suggestion text,
  id int(11) NOT NULL AUTO_INCREMENT,
  rank_one int(11) DEFAULT NULL,
  rank_two int(11) DEFAULT NULL,
  rank_three int(11) DEFAULT NULL,
  rank_four int(11) DEFAULT NULL,
  PRIMARY KEY (id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;


--
-- Table structure for table posts
--

DROP TABLE IF EXISTS posts;


CREATE TABLE posts (
  id int(11) NOT NULL AUTO_INCREMENT,
  user_id int(11) DEFAULT NULL,
  topic_id int(11) DEFAULT NULL,
  body text,
  forum_id int(11) DEFAULT NULL,
  body_html text,
  created_at datetime DEFAULT NULL,
  updated_at datetime DEFAULT NULL,
  diary_from datetime DEFAULT NULL,
  diary_to datetime DEFAULT NULL,
  PRIMARY KEY (id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;


--
-- Table structure for table posts_sweepers
--

DROP TABLE IF EXISTS posts_sweepers;


CREATE TABLE posts_sweepers (
  id int(11) NOT NULL AUTO_INCREMENT,
  created_at datetime DEFAULT NULL,
  updated_at datetime DEFAULT NULL,
  PRIMARY KEY (id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;


--
-- Table structure for table schema_migrations
--

DROP TABLE IF EXISTS schema_migrations;


CREATE TABLE schema_migrations (
  version varchar(255) NOT NULL,
  UNIQUE KEY unique_schema_migrations (version)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;


--
-- Table structure for table sessions
--

DROP TABLE IF EXISTS sessions;


CREATE TABLE sessions (
  id int(11) NOT NULL AUTO_INCREMENT,
  session_id varchar(255) NOT NULL,
  data text,
  created_at datetime DEFAULT NULL,
  updated_at datetime DEFAULT NULL,
  PRIMARY KEY (id),
  KEY index_sessions_on_session_id (session_id),
  KEY index_sessions_on_updated_at (updated_at)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;


--
-- Table structure for table site_settings
--

DROP TABLE IF EXISTS site_settings;


CREATE TABLE site_settings (
  id int(11) NOT NULL AUTO_INCREMENT,
  name varchar(255) DEFAULT NULL,
  value varchar(255) DEFAULT NULL,
  PRIMARY KEY (id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;


--
-- Table structure for table topics
--

DROP TABLE IF EXISTS topics;


CREATE TABLE topics (
  id int(11) NOT NULL AUTO_INCREMENT,
  forum_id int(11) DEFAULT NULL,
  user_id int(11) DEFAULT NULL,
  title varchar(255) DEFAULT NULL,
  hits int(11) DEFAULT '0',
  sticky int(11) DEFAULT '0',
  posts_count int(11) DEFAULT '0',
  replied_at datetime DEFAULT NULL,
  locked int(11) DEFAULT '0',
  replied_by int(11) DEFAULT NULL,
  last_post_id int(11) DEFAULT NULL,
  created_at datetime DEFAULT NULL,
  updated_at datetime DEFAULT NULL,
  PRIMARY KEY (id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;


--
-- Table structure for table user_mailers
--

DROP TABLE IF EXISTS user_mailers;


CREATE TABLE user_mailers (
  id int(11) NOT NULL AUTO_INCREMENT,
  created_at datetime DEFAULT NULL,
  updated_at datetime DEFAULT NULL,
  PRIMARY KEY (id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;


--
-- Table structure for table user_ratios
--

DROP TABLE IF EXISTS user_ratios;


CREATE TABLE user_ratios (
  id int(11) NOT NULL AUTO_INCREMENT,
  user_id int(11) DEFAULT NULL,
  ratio varchar(255) DEFAULT NULL,
  action int(11) DEFAULT NULL,
  created_at datetime DEFAULT NULL,
  updated_at datetime DEFAULT NULL,
  PRIMARY KEY (id)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


--
-- Table structure for table user_settings
--

DROP TABLE IF EXISTS user_settings;


CREATE TABLE user_settings (
  id int(11) NOT NULL AUTO_INCREMENT,
  diary_day_end varchar(255) DEFAULT NULL,
  user_id int(11) DEFAULT NULL,
  created_at datetime DEFAULT NULL,
  updated_at datetime DEFAULT NULL,
  diary_colourize tinyint(1) DEFAULT NULL,
  PRIMARY KEY (id)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


--
-- Table structure for table users
--

DROP TABLE IF EXISTS users;


CREATE TABLE users (
  id int(11) NOT NULL AUTO_INCREMENT,
  login varchar(255) DEFAULT NULL,
  email varchar(255) DEFAULT NULL,
  password_hash varchar(255) DEFAULT NULL,
  last_login_at datetime DEFAULT NULL,
  usertype_id int(11) DEFAULT NULL,
  posts_count int(11) DEFAULT NULL,
  last_seen_at datetime DEFAULT NULL,
  display_name varchar(255) DEFAULT NULL,
  login_key varchar(255) DEFAULT NULL,
  login_key_expires_at datetime DEFAULT NULL,
  activated int(11) DEFAULT NULL,
  bio text,
  bio_html text,
  dafne_centre_id int(11) DEFAULT NULL,
  created_at datetime DEFAULT NULL,
  updated_at datetime DEFAULT NULL,
  topic_notify tinyint(1) DEFAULT '1',
  DGG_notify tinyint(1) DEFAULT '0',
  PRIMARY KEY (id),
  KEY userCentre (dafne_centre_id) USING BTREE,
  KEY userTypes (usertype_id) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;


--
-- Table structure for table usertypes
--

DROP TABLE IF EXISTS usertypes;


CREATE TABLE usertypes (
  id int(11) NOT NULL AUTO_INCREMENT,
  userlevel int(11) DEFAULT '0',
  description varchar(255) DEFAULT NULL,
  long_desc varchar(255) DEFAULT NULL,
  PRIMARY KEY (id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
