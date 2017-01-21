# c9-secure

# Secure installation of Cloud9

### How to run

Simply deploy with the command:

```docker run -d --name c9-secure -p 8181:8181 -v /path/to/your/workspace:/opt/cloud9/workspace elautoestopista/c9-secure:latest```

If you want only local access (p.e. you want to proxify it with nginx or similar) just run:

```docker run -d --name c9-secure -p 8181:8181 -v /path/to/your/workspace:/opt/cloud9/workspace elautoestopista/c9-secure:latest```

Default user/password: admin/admin

TODO: TLS implementation not yet done.
