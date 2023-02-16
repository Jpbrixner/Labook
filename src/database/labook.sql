-- Active: 1675445253561@@127.0.0.1@3306
CREATE TABLE
    users (
        id TEXT PRIMARY KEY UNIQUE NOT NULL,
        name TEXT NOT NULL,
        email TEXT UNIQUE NOT NULL,
        password TEXT NOT NULL, 
        role TEXT NOT NULL,
        created_at TEXT DEFAULT (DATETIME()) NOT NULL
    );

CREATE TABLE
    posts (
        id TEXT PRIMARY KEY UNIQUE NOT NULL,
        creator_id TEXT NOT NULL,
        content TEXT NOT NULL,
        likes INTEGER DEFAULT (0) NOT NULL,
        dislikes INTEGER DEFAULT (0) NOT NULL,
        created_at TEXT DEFAULT (DATETIME()) NOT NULL,
        updated_at TEXT DEFAULT (DATETIME()) NOT NULL,
        FOREIGN KEY (creator_id) REFERENCES users(id) 
            ON DELETE CASCADE
            ON UPDATE CASCADE
    );

CREATE TABLE
    likes_dislikes (
        users_id TEXT NOT NULL,
        posts_id TEXT NOT NULL,
        like INTEGER NOT NULL,
        FOREIGN KEY (users_id) REFERENCES users (id)
            ON DELETE CASCADE
            ON UPDATE CASCADE,
        FOREIGN KEY (posts_id) REFERENCES posts (id)
            ON DELETE CASCADE
            ON UPDATE CASCADE
    );

INSERT INTO
    users (id, name, email, password, role)
VALUES (
        "u001",
        "Fulano",
        "fulano@email.com",
        "fulano123",
        "NORMAL"
    ), (
        "u002",
        "Beltrana",
        "beltrana@email.com",
        "beltrana00",
        "ADMIN"
    );

INSERT INTO
    posts (id, creator_id, content)
VALUES (
        "p001",
        "u001",
        "Bom Dia! Dia lindo hoje."
    ), (
        "p002",
        "u002",
        "Bora marcar um churrasco galera!"
    ), (
        "p003",
        "u002",
        "Vou ao estádio assistir o jogo de hoje!"
    ), (
        "p004",
        "u001",
        "Quem está afim de pegar uma praia hoje?"
    );

INSERT INTO
    likes_dislikes (users_id, posts_id, like)
VALUES ("u001", "p002", 1), ("u002", "p001", 1), ("u001", "p003", 1), ("u002", "p004", 0);

UPDATE posts
SET likes = 1
WHERE id = "p001";

UPDATE posts
SET likes = 1
WHERE id = "p002";

UPDATE posts
SET likes = 1
WHERE id = "p003";

UPDATE posts
SET dislikes = 1
WHERE id = "p004";

SELECT
    posts.id,
    posts.creator_id,
    posts.content,
    posts.likes,
    posts.dislikes,
    posts.created_at,
    posts.updated_at,
    users.name AS creator_name
FROM posts
JOIN users
ON posts.creator_id = users.id;

SELECT * FROM posts;
SELECT * FROM likes_dislikes;