# terraform-aws-private-ecr-domain [![GitHub Actions][actions.svg]][actions]

An example module hoping to be [a drop-in solution for aws/containers-roadmap#299][aws-containers-roadmap-299].

The goal is to allow you to use a custom domain name with an ACM certificate to access your private ECR registry,
however, certain aspects are not working at present, and _ANY AND ALL HELP IS WELCOMED_ ❤️

Please help.

## Background

Apparently, all that is needed to make things work is to simply rewrite the `Host` header on the edge to match the
ECR domain name, which is `${AWS_ACCOUNT_ID}.dkr.ecr.${AWS_REGION}.amazonaws.com`. To this end, a Lambda@Edge function in
NodeJS is included, and it does exactly this.

However, certain operations still fail, perhaps due to some strange Lambda@Edge behavior, or CloudFront caching
behavior, or CloudFront origin request behavior, and observing these issues has proved to be a total nightmare.

## What Works

✔️ `aws ecr get-login-password | docker login -u AWS --password-stdin docker.mycompany.com`

Login works.

✔️ `docker pull docker.mycompany.com/org/repo;:latest`

Pulling images works.

## What Does Not Work

✖️ `docker push docker.mycompany.com/org/repo:latest`

Pushing images does not work:

```text
The push refers to repository [docker.mycompany.com/org/repo]
fac15b2caa0c: Pushing [==================================================>]  7.168kB
f8bf5746ac5a: Pushing [==================================================>]  3.584kB
d11eedadbd34: Pushing [==================================================>]  4.096kB
797e583d8c50: Pushing [==================================================>]  3.072kB
bf9ce92e8516: Preparing 
d000633a5681: Waiting 
unauthorized: authentication required
```

For the life of me, I cannot figure out what is failing here, and logs from Lambda@Edge don't seem to give me any
indication. By the way, to effectively tail Lambda@Edge, you will need to run:

```
aws --region $REGION logs tail $LAMBDA_LOG_GROUP
```

However, you will need to run _N_ of these processes in parallel, as you have no guarantees as to which region your
Lambda@Edge function runs in. This makes things especially frustrating. I wrote some Rust utility in anger, which will
tail and aggregate multiple regions, but it's not in a place where I feel like I could publish the utility.

Other solutions have used NGINX to rewrite the `Host` header and NGINX actually works. Therefore, I suspect that there
is some awful CloudFront activity going on between the Lambda@Edge invocation and the actual request to the ECR origin.

## Debugging

Ideally, as recommended by @WhyNotHugo and what I've expected, to debug this setup will likely require setting up a
MITM proxy between CloudFront and ECR to see exactly what requests are being sent from the edge to the origin and which
requests are failing. To this end, testing will be done to see what is actually happening to be be able to debug the
system.

Since `docker login` and `docker pull` both work, but `docker pull` does not, we need to determine what requests
`docker push` performs in order to see what request is actually failing. Setting up a MITM proxy between CloudFront and
the origin should give us an adequate idea of what is actually happening.

## Usage

Please see [`USAGE.md`](./USAGE.md) for usage information and description of parameters and outputs for the module.

## License

Licensed at your discretion under either 

 - [Apache Software License, Version 2.0](./LICENSE-APACHE)
 - [MIT License](./LICENSE-MIT)

 [aws-containers-roadmap-299]: https://github.com/aws/containers-roadmap/issues/299
 [actions]: https://github.com/naftulikay/terraform-aws-private-ecr-domain/actions/workflows/terraform.yml
 [actions.svg]: https://github.com/naftulikay/terraform-aws-private-ecr-domain/actions/workflows/terraform.yml/badge.svg
