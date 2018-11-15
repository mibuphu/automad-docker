# Automad CMS Docker image

## About Automad
Automad is a flat content management system and template engine written in PHP. All content is stored in human readable text files instead of a database. An Automad site is therefore fully portable, easy to install and can be version controlled by using Git or Mercurial. It nevertheless offers database features like searching and tagging. The built-in template engine allows even inexperienced developers and designers to create beautiful themes and templates.
[source](https://automad.org/)


## Note
This image was build as part of an exercise and learning experience in my journey to Docker. 
I was searching for some lightweight CMS for my personal website and stumbled across different flatfile systems. Since most of the others had a docker images, it made testing on my local machine pretty easy. Sadly Automad didn't offer that, so here I am writing this image myself and sharing it with everyone. I hope it helps :)

## Requirements
- docker

## HOWTO
To run this docker image, run the following commands:

1. docker pull bpminh/automad
2. docker run -d -p 8000:80 bpminh/automad
3. type "localhost:8000" in your browser address bar

## Credentials
The default credentials for the backend area are:
```
user: admin
pwd: admin
```

## Credits
Credits go to Marc Anton Dahmen, the awesome developer of Automad
[credits](https://marcdahmen.de/)


## Contact
Minh Bui
- [website](http://codingeering.com)
- [mail](mibuphu@gmail.com)