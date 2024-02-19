# Sub-Magazines

Sub-magazines subscribes to the [magazine repo](https://github.com/hehonghui/awesome-english-ebooks) and sends newly added `epub` format files to my Kindle by email. It checks the latest commit on the master branch daily with the help of scheduled github action. Currently, it supports hardcoded destination only.

## Configuration Scheme

The Github action relies on configurations in environment variables.

- `SMTP_CONFIG`:  
   The format of `SMTP_CONFIG` is JSON. It could be set up directly on github page. If you want to set up it by shell, please squash multiple lines to one line and add `\` before `"`.

  ```json
  {
    "name": "name",
    "email": "email@demo.com",
    "password": "password",
    "host": "localhost",
    "destination": "destination"
  }
  ```

- `TOKEN_GITHUB`: String format.

### Local Debug

Exporting the environment variables like this:
```sh
export SMTP_CONFIG="{\"name\":\"xieyuschen\",\"email\":\"example@gmail.com\",\"password\":\"your-password\",\"host\":\"smtp.gmail.com\",\"destination\":\"destination@kindle.cn\"}"
export TOKEN_GITHUB=github_blablabla
```
