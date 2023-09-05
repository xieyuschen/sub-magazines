module Common where

emailConfigJsonStr :: String
emailConfigJsonStr =
    "{ \
    \     \"name\": \"name\", \
    \     \"email\": \"email@demo.com\", \
    \     \"password\": \"password\", \
    \     \"host\": \"localhost\", \
    \     \"destination\": \"destination\" \
    \ } "

-- use vim to manupulate a pure json string to haskell literal string
-- step1:
-- :'<,'>s/\"/\\"/g
-- step2:
-- <c-V> to enter visual block mode
-- A to enter insert mode
-- insert \ at the start of line and the end of line
githubCommitDetailJsonStr :: String
githubCommitDetailJsonStr =
    " { \
    \     \"sha\": \"44f9460c97accd8b003bff4060f6ed5760cf62f3\", \
    \     \"node_id\": \"C_kwDOHkl5T9oAKDQ0Zjk0NjBjOTdhY2NkOGIwMDNiZmY0MDYwZjZlZDU3NjBjZjYyZjM\", \
    \     \"commit\": { \
    \         \"author\": { \
    \             \"name\": \"hehonghui\", \
    \             \"email\": \"simplecoder.h@gmail.com\", \
    \             \"date\": \"2023-09-01T23:13:11Z\" \
    \         }, \
    \         \"committer\": { \
    \             \"name\": \"hehonghui\", \
    \             \"email\": \"simplecoder.h@gmail.com\", \
    \             \"date\": \"2023-09-01T23:13:11Z\" \
    \         }, \
    \         \"message\": \"update magazine 2023.09.02\", \
    \         \"tree\": { \
    \             \"sha\": \"1689f46d9d71b7d79e110ef76e314a6040ce0844\", \
    \             \"url\": \"https://api.github.com/repos/hehonghui/awesome-english-ebooks/git/trees/1689f46d9d71b7d79e110ef76e314a6040ce0844\" \
    \         }, \
    \         \"url\": \"https://api.github.com/repos/hehonghui/awesome-english-ebooks/git/commits/44f9460c97accd8b003bff4060f6ed5760cf62f3\", \
    \         \"comment_count\": 0, \
    \         \"verification\": { \
    \             \"verified\": false, \
    \             \"reason\": \"unsigned\", \
    \             \"signature\": null, \
    \             \"payload\": null \
    \         } \
    \     }, \
    \     \"url\": \"https://api.github.com/repos/hehonghui/awesome-english-ebooks/commits/44f9460c97accd8b003bff4060f6ed5760cf62f3\", \
    \     \"html_url\": \"https://github.com/hehonghui/awesome-english-ebooks/commit/44f9460c97accd8b003bff4060f6ed5760cf62f3\", \
    \     \"comments_url\": \"https://api.github.com/repos/hehonghui/awesome-english-ebooks/commits/44f9460c97accd8b003bff4060f6ed5760cf62f3/comments\", \
    \     \"author\": { \
    \         \"login\": \"hehonghui\", \
    \         \"id\": 1683811, \
    \         \"node_id\": \"MDQ6VXNlcjE2ODM4MTE=\", \
    \         \"avatar_url\": \"https://avatars.githubusercontent.com/u/1683811?v=4\", \
    \         \"gravatar_id\": \"\", \
    \         \"url\": \"https://api.github.com/users/hehonghui\", \
    \         \"html_url\": \"https://github.com/hehonghui\", \
    \         \"followers_url\": \"https://api.github.com/users/hehonghui/followers\", \
    \         \"following_url\": \"https://api.github.com/users/hehonghui/following{/other_user}\", \
    \         \"gists_url\": \"https://api.github.com/users/hehonghui/gists{/gist_id}\", \
    \         \"starred_url\": \"https://api.github.com/users/hehonghui/starred{/owner}{/repo}\", \
    \         \"subscriptions_url\": \"https://api.github.com/users/hehonghui/subscriptions\", \
    \         \"organizations_url\": \"https://api.github.com/users/hehonghui/orgs\", \
    \         \"repos_url\": \"https://api.github.com/users/hehonghui/repos\", \
    \         \"events_url\": \"https://api.github.com/users/hehonghui/events{/privacy}\", \
    \         \"received_events_url\": \"https://api.github.com/users/hehonghui/received_events\", \
    \         \"type\": \"User\", \
    \         \"site_admin\": false \
    \     }, \
    \     \"committer\": { \
    \         \"login\": \"hehonghui\", \
    \         \"id\": 1683811, \
    \         \"node_id\": \"MDQ6VXNlcjE2ODM4MTE=\", \
    \         \"avatar_url\": \"https://avatars.githubusercontent.com/u/1683811?v=4\", \
    \         \"gravatar_id\": \"\", \
    \         \"url\": \"https://api.github.com/users/hehonghui\", \
    \         \"html_url\": \"https://github.com/hehonghui\", \
    \         \"followers_url\": \"https://api.github.com/users/hehonghui/followers\", \
    \         \"following_url\": \"https://api.github.com/users/hehonghui/following{/other_user}\", \
    \         \"gists_url\": \"https://api.github.com/users/hehonghui/gists{/gist_id}\", \
    \         \"starred_url\": \"https://api.github.com/users/hehonghui/starred{/owner}{/repo}\", \
    \         \"subscriptions_url\": \"https://api.github.com/users/hehonghui/subscriptions\", \
    \         \"organizations_url\": \"https://api.github.com/users/hehonghui/orgs\", \
    \         \"repos_url\": \"https://api.github.com/users/hehonghui/repos\", \
    \         \"events_url\": \"https://api.github.com/users/hehonghui/events{/privacy}\", \
    \         \"received_events_url\": \"https://api.github.com/users/hehonghui/received_events\", \
    \         \"type\": \"User\", \
    \         \"site_admin\": false \
    \     }, \
    \     \"parents\": [ \
    \         { \
    \             \"sha\": \"b551a6eb4560dff23c73818a1bdf6b22600885f9\", \
    \             \"url\": \"https://api.github.com/repos/hehonghui/awesome-english-ebooks/commits/b551a6eb4560dff23c73818a1bdf6b22600885f9\", \
    \             \"html_url\": \"https://github.com/hehonghui/awesome-english-ebooks/commit/b551a6eb4560dff23c73818a1bdf6b22600885f9\" \
    \         } \
    \     ], \
    \     \"stats\": { \
    \         \"total\": 0, \
    \         \"additions\": 0, \
    \         \"deletions\": 0 \
    \     }, \
    \     \"files\": [ \
    \         { \
    \             \"sha\": \"af2bf9947d05029f63f968790d3739707e446f87\", \
    \             \"filename\": \"04_atlantic/2023.09.02/Atlantic_2023.09.02.epub\", \
    \             \"status\": \"added\", \
    \             \"additions\": 0, \
    \             \"deletions\": 0, \
    \             \"changes\": 0, \
    \             \"blob_url\": \"https://github.com/hehonghui/awesome-english-ebooks/blob/44f9460c97accd8b003bff4060f6ed5760cf62f3/04_atlantic%2F2023.09.02%2FAtlantic_2023.09.02.epub\", \
    \             \"raw_url\": \"https://github.com/hehonghui/awesome-english-ebooks/raw/44f9460c97accd8b003bff4060f6ed5760cf62f3/04_atlantic%2F2023.09.02%2FAtlantic_2023.09.02.epub\", \
    \             \"contents_url\": \"https://api.github.com/repos/hehonghui/awesome-english-ebooks/contents/04_atlantic%2F2023.09.02%2FAtlantic_2023.09.02.epub?ref=44f9460c97accd8b003bff4060f6ed5760cf62f3\" \
    \         }, \
    \         { \
    \             \"sha\": \"32382458dabd6e1ddcc46e2b4a2db97721f66091\", \
    \             \"filename\": \"04_atlantic/2023.09.02/Atlantic_2023.09.02.pdf\", \
    \             \"status\": \"added\", \
    \             \"additions\": 0, \
    \             \"deletions\": 0, \
    \             \"changes\": 0, \
    \             \"blob_url\": \"https://github.com/hehonghui/awesome-english-ebooks/blob/44f9460c97accd8b003bff4060f6ed5760cf62f3/04_atlantic%2F2023.09.02%2FAtlantic_2023.09.02.pdf\", \
    \             \"raw_url\": \"https://github.com/hehonghui/awesome-english-ebooks/raw/44f9460c97accd8b003bff4060f6ed5760cf62f3/04_atlantic%2F2023.09.02%2FAtlantic_2023.09.02.pdf\", \
    \             \"contents_url\": \"https://api.github.com/repos/hehonghui/awesome-english-ebooks/contents/04_atlantic%2F2023.09.02%2FAtlantic_2023.09.02.pdf?ref=44f9460c97accd8b003bff4060f6ed5760cf62f3\" \
    \         }, \
    \         { \
    \             \"sha\": \"d07daa9610bbecc04169d810766d7c6c97be1500\", \
    \             \"filename\": \"05_wired/2023.09.02/wired_2023.09.02.epub\", \
    \             \"status\": \"added\", \
    \             \"additions\": 0, \
    \             \"deletions\": 0, \
    \             \"changes\": 0, \
    \             \"blob_url\": \"https://github.com/hehonghui/awesome-english-ebooks/blob/44f9460c97accd8b003bff4060f6ed5760cf62f3/05_wired%2F2023.09.02%2Fwired_2023.09.02.epub\", \
    \             \"raw_url\": \"https://github.com/hehonghui/awesome-english-ebooks/raw/44f9460c97accd8b003bff4060f6ed5760cf62f3/05_wired%2F2023.09.02%2Fwired_2023.09.02.epub\", \
    \             \"contents_url\": \"https://api.github.com/repos/hehonghui/awesome-english-ebooks/contents/05_wired%2F2023.09.02%2Fwired_2023.09.02.epub?ref=44f9460c97accd8b003bff4060f6ed5760cf62f3\" \
    \         }, \
    \         { \
    \             \"sha\": \"3b2d412859bff41ba06ab6d6d380f3172e296932\", \
    \             \"filename\": \"05_wired/2023.09.02/wired_2023.09.02.pdf\", \
    \             \"status\": \"added\", \
    \             \"additions\": 0, \
    \             \"deletions\": 0, \
    \             \"changes\": 0, \
    \             \"blob_url\": \"https://github.com/hehonghui/awesome-english-ebooks/blob/44f9460c97accd8b003bff4060f6ed5760cf62f3/05_wired%2F2023.09.02%2Fwired_2023.09.02.pdf\", \
    \             \"raw_url\": \"https://github.com/hehonghui/awesome-english-ebooks/raw/44f9460c97accd8b003bff4060f6ed5760cf62f3/05_wired%2F2023.09.02%2Fwired_2023.09.02.pdf\", \
    \             \"contents_url\": \"https://api.github.com/repos/hehonghui/awesome-english-ebooks/contents/05_wired%2F2023.09.02%2Fwired_2023.09.02.pdf?ref=44f9460c97accd8b003bff4060f6ed5760cf62f3\" \
    \         } \
    \     ] \
    \ }"
