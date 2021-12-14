#!/usr/bin/env node

// serverfault answer: https://serverfault.com/a/888776/70024
// event data structure: https://docs.aws.amazon.com/lambda/latest/dg/lambda-edge.html
// (many) limitations on Lambda@Edge: https://docs.aws.amazon.com/AmazonCloudFront/latest/DeveloperGuide/edge-functions-restrictions.html
// lambda implementation of https://github.com/aws/containers-roadmap/issues/299#issuecomment-947148191

/**
 * Callback function for a Cloudfront Lambda@Edge request event. Rewrites the `Host` header to match the specified
 * registry host-name.
 * @param event The Cloudfront Lambda event.
 * @param context Lambda event context.
 * @param callback Callback to fire upon complete.
 * @returns {*} Invocation result of callback.
 */
exports.handler = (event, context, callback) => {
    const request = event.Records[0].cf.request;
    const headers = request.headers;

    // NOTE X-Forwarded-Proto and X-Real-IP (among others) are not exposed to Lambda@Edge and cannot be read/set/modified
    headers["host"] = [{"key": "Host", "value": request.origin.custom.domainName}];
    headers["x-forwarded-for"] = [{"key": "X-Forwarded-For", "value": request.clientIp}];

    console.log("HTTP Request:\n" + display(request) + "\n" + LONGBAR);

    callback(null, request);
}

/**
 * Format a HTTP request object into a human-readable string for debugging.
 * @param request The CloudFront request object from `event.Records[*].cf.request`.
 * @returns {string} An HTTP request formatted as a string in a format similar to the wire implementation.
 */
function display(request) {
    let uri = request.uri;
    let qs = request.querystring;
    let method = request.method;

    if (qs.length > 0) {
        uri = uri + "?" + qs;
    }

    let lines = ["{method} {uri} HTTP/1.1".supplant({method: method, uri: uri})];

    for (const [_, headerValues] of Object.entries(request.headers)) {
        for (const entry of headerValues) {
            lines.push("{header}: {value}".supplant({header: entry.key, value: entry.value}));
        }
    }

    return lines.join("\n");
}

// string interpolation: https://stackoverflow.com/a/1408373/128967
String.prototype.supplant = function (o) {
    return this.replace(/{([^{}]*)}/g,
        function (a, b) {
            let r = o[b];
            return typeof r === 'string' || typeof r === 'number' ? r : a;
        }
    );
};

const LONGBAR = "-----------------------------------------------------------------------------------------------------"
