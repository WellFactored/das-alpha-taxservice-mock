# --- !Ups

CREATE TABLE "scheme" (
  "empref"           VARCHAR NOT NULL PRIMARY KEY,
  "termination_date" DATE    NULL
);

INSERT INTO "scheme" ("empref") VALUES ('123/AB12345');
INSERT INTO "scheme" ("empref") VALUES ('123/BC12345');
INSERT INTO "scheme" ("empref") VALUES ('321/ZX54321');
INSERT INTO "scheme" ("empref") VALUES ('222/MM22222');

CREATE TABLE "gateway_id" (
  "id"       VARCHAR NOT NULL PRIMARY KEY,
  "password" VARCHAR NOT NULL
);

INSERT INTO "gateway_id" ("id", "password") VALUES ('gateway1', 'password');
INSERT INTO "gateway_id" ("id", "password") VALUES ('gateway2', 'password');

CREATE TABLE "client" (
  "id"           VARCHAR NOT NULL PRIMARY KEY,
  "secret"       VARCHAR NULL,
  "redirect_uri" VARCHAR NULL,
  "scope"        VARCHAR NULL,
  "grant_type"   VARCHAR NOT NULL
);

INSERT INTO "client" ("id", "secret", "redirect_uri", "scope", "grant_type")
VALUES ('client1', 'secret1', '', '', 'authorization_code');
INSERT INTO "client" ("id", "secret", "redirect_uri", "scope", "grant_type")
VALUES ('daniel.ashton@valtech.co.uk', 'password', '', '', 'authorization_code');
INSERT INTO "client" ("id", "secret", "redirect_uri", "scope", "grant_type")
VALUES ('ian.russell@valtech.co.uk', 'password', '', '', 'authorization_code');

CREATE TABLE "auth_codes" (
  "authorization_code" VARCHAR NOT NULL PRIMARY KEY,
  "gateway_id"         VARCHAR NOT NULL REFERENCES "gateway_id",
  "redirect_uri"       VARCHAR NOT NULL,
  "created_at"         BIGINT  NOT NULL,
  "scope"              VARCHAR NULL,
  "client_id"          VARCHAR NOT NULL,
  "expires_in"         INTEGER NOT NULL
);

CREATE TABLE "access_token" (
  "access_token"  VARCHAR NOT NULL PRIMARY KEY,
  "refresh_token" VARCHAR NULL,
  "gateway_id"    VARCHAR NOT NULL REFERENCES "gateway_id",
  "scope"         VARCHAR NULL,
  "expires_in"    INTEGER NOT NULL,
  "created_at"    BIGINT  NOT NULL,
  "client_id"     VARCHAR NOT NULL
);

# --- !Downs


DROP TABLE "access_token";
DROP TABLE "auth_codes";
DROP TABLE "client";

DROP TABLE "gateway_id";
DROP TABLE "scheme";
