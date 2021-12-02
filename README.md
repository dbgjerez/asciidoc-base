# Document as a code
Document as a code is a concept to use the power of Git and get the advantage of it. 

When we document a project, it is very important that the documentation and the project code are synchronized. Another significant tip is that the documentation should be public and accessible inside the organization. 

This repo helps to public and maintain it.

## Build
To build the project, you can use asciidoctor for both options, pdf or html. 
I recommend you to use the html option and serve it with a http server.

### Asciidoctor
#### html 
```bash
    $ asciidoctor content/index.adoc -o index.html
```

#### pdf 
```bash
    $ asciidoctor-pdf content/index.adoc -o doc.pdf
```

### Docker
To use a container to build is my favourite option because you can do it immutable, and ensure that you are building always with the best version of your product.

#### html
```bash
    $   docker run -it \
        -v $(pwd):/documents \
        asciidoctor/docker-asciidoctor \
        asciidoctor content/index.adoc \
        -o index.html
```

#### pdf
```bash
    $   docker run -it \
        -v $(pwd):/documents \
        asciidoctor/docker-asciidoctor \
        asciidoctor-pdf content/index.adoc \
        -o doc.pdf
```