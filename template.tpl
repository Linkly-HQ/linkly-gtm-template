___TERMS_OF_SERVICE___

By creating or modifying this file you agree to Google Tag Manager's Community
Template Gallery Developer Terms of Service available at
https://developers.google.com/tag-manager/gallery-tos (or such other URL as
Google may provide), as modified from time to time.


___INFO___

{
  "type": "TAG",
  "id": "cvt_temp_public_id",
  "version": 1,
  "securityGroups": [],
  "displayName": "Linkly Conversion Tracking",
  "categories": ["ANALYTICS", "ATTRIBUTION", "CONVERSIONS"],
  "brand": {
    "id": "brand_dummy",
    "displayName": "Linkly"
  },
  "description": "Attribute sales and leads back to the Linkly short link that caused them. Add the Initialise tag on Initialisation - All Pages. Sites already firing GA4 ecommerce events need no other tag.",
  "containerContexts": ["WEB"]
}


___TEMPLATE_PARAMETERS___

[
  {
    "type": "SELECT",
    "name": "tagType",
    "displayName": "Tag Type",
    "macrosInSelect": false,
    "selectItems": [
      {
        "value": "init",
        "displayValue": "Initialise (fire on Initialisation - All Pages)"
      },
      {
        "value": "sale",
        "displayValue": "Track Sale"
      },
      {
        "value": "lead",
        "displayValue": "Track Lead"
      }
    ],
    "simpleValueType": true,
    "defaultValue": "init",
    "help": "Initialise loads the tracker and captures the attribution token. It must fire on every page, not just the page you are tracking: the token arrives on the landing URL, so a tag that only fires at checkout has nothing left to capture."
  },
  {
    "type": "GROUP",
    "name": "initGroup",
    "displayName": "Attribution Settings",
    "groupStyle": "NO_ZIPPY",
    "subParams": [
      {
        "type": "TEXT",
        "name": "cookieDomain",
        "displayName": "Cookie Domain",
        "simpleValueType": true,
        "help": "Set this to <code>.example.com</code> if your checkout lives on a different subdomain from your landing pages. Browser storage is locked to one exact origin, so without this the token cannot follow a visitor from www to checkout and those sales will not attribute. Leave blank if everything is on one hostname.",
        "valueValidators": [
          {
            "type": "REGEX",
            "args": ["^$|^\\.?[a-zA-Z0-9]([a-zA-Z0-9-]*[a-zA-Z0-9])?(\\.[a-zA-Z0-9]([a-zA-Z0-9-]*[a-zA-Z0-9])?)+$"],
            "errorMessage": "Enter a bare domain such as .example.com — no scheme, port or path."
          }
        ]
      },
      {
        "type": "TEXT",
        "name": "ttlDays",
        "displayName": "Attribution Window (days)",
        "simpleValueType": true,
        "defaultValue": "90",
        "valueValidators": [
          {
            "type": "POSITIVE_NUMBER"
          }
        ],
        "help": "How long after the click a conversion still counts."
      },
      {
        "type": "CHECKBOX",
        "name": "cleanUrl",
        "checkboxText": "Remove the tracking parameter from the address bar",
        "simpleValueType": true,
        "defaultValue": true,
        "help": "Keeps <code>linkly_cid</code> out of shared links and bookmarks. Untick if another tag needs to read it from the URL — that tag must then run before this one."
      }
    ],
    "enablingConditions": [
      {
        "paramName": "tagType",
        "paramValue": "init",
        "type": "EQUALS"
      }
    ]
  },
  {
    "type": "GROUP",
    "name": "ga4Group",
    "displayName": "GA4 Ecommerce Bridge",
    "groupStyle": "ZIPPY_OPEN",
    "subParams": [
      {
        "type": "CHECKBOX",
        "name": "ga4Bridge",
        "checkboxText": "Record conversions from GA4 ecommerce events automatically",
        "simpleValueType": true,
        "defaultValue": true,
        "help": "If your site already pushes GA4 ecommerce events to the data layer, this picks up purchases on its own and you do not need a Track Sale tag at all. Repeat events carrying the same transaction ID are counted once, so a refreshed confirmation page will not double up."
      },
      {
        "type": "TEXT",
        "name": "ga4Events",
        "displayName": "Events To Treat As Conversions",
        "simpleValueType": true,
        "defaultValue": "purchase",
        "help": "Comma separated. Add your own, for example <code>purchase,generate_lead</code>.",
        "enablingConditions": [
          {
            "paramName": "ga4Bridge",
            "paramValue": true,
            "type": "EQUALS"
          }
        ]
      }
    ],
    "enablingConditions": [
      {
        "paramName": "tagType",
        "paramValue": "init",
        "type": "EQUALS"
      }
    ]
  },
  {
    "type": "GROUP",
    "name": "saleGroup",
    "displayName": "Sale Details",
    "groupStyle": "NO_ZIPPY",
    "subParams": [
      {
        "type": "TEXT",
        "name": "saleEventName",
        "displayName": "Event Name",
        "simpleValueType": true,
        "defaultValue": "purchase",
        "valueValidators": [
          {
            "type": "NON_EMPTY"
          }
        ]
      },
      {
        "type": "TEXT",
        "name": "amount",
        "displayName": "Amount (minor units)",
        "simpleValueType": true,
        "help": "In the smallest unit of the currency: <strong>4999</strong> means £49.99, not £4999. Most data layers hold a decimal, so multiply by 100 in a variable before passing it here.",
        "valueValidators": [
          {
            "type": "POSITIVE_NUMBER"
          }
        ]
      },
      {
        "type": "TEXT",
        "name": "currency",
        "displayName": "Currency",
        "simpleValueType": true,
        "defaultValue": "USD",
        "valueValidators": [
          {
            "type": "REGEX",
            "args": ["^$|^[A-Za-z]{3}$"],
            "errorMessage": "Use a three letter ISO code such as USD, GBP or EUR."
          }
        ]
      },
      {
        "type": "TEXT",
        "name": "eventId",
        "displayName": "Order ID",
        "simpleValueType": true,
        "help": "Strongly recommended. Used to discard duplicates, so a customer who refreshes the confirmation page is not counted twice. Without it, a refresh is a second sale."
      }
    ],
    "enablingConditions": [
      {
        "paramName": "tagType",
        "paramValue": "sale",
        "type": "EQUALS"
      }
    ]
  },
  {
    "type": "GROUP",
    "name": "leadGroup",
    "displayName": "Lead Details",
    "groupStyle": "NO_ZIPPY",
    "subParams": [
      {
        "type": "TEXT",
        "name": "leadEventName",
        "displayName": "Event Name",
        "simpleValueType": true,
        "defaultValue": "signup",
        "valueValidators": [
          {
            "type": "NON_EMPTY"
          }
        ]
      },
      {
        "type": "TEXT",
        "name": "leadEventId",
        "displayName": "Event ID",
        "simpleValueType": true,
        "help": "Optional. Used to discard duplicates if the same lead can be submitted twice."
      }
    ],
    "enablingConditions": [
      {
        "paramName": "tagType",
        "paramValue": "lead",
        "type": "EQUALS"
      }
    ]
  },
  {
    "type": "TEXT",
    "name": "customerId",
    "displayName": "Customer ID",
    "simpleValueType": true,
    "help": "Optional. Your own ID for the customer. Ties later conversions to the same person, so a signup today and a purchase next month both credit the original link.",
    "enablingConditions": [
      {
        "paramName": "tagType",
        "paramValue": "init",
        "type": "NOT_EQUALS"
      }
    ]
  }
]


___SANDBOXED_JS_FOR_WEB_TEMPLATE___

// Linkly conversion tracking.
//
// Two jobs, split across the tag types. "Initialise" loads cdn.linklyhq.com's
// linkly.js and lets it capture the attribution token from the landing URL.
// "Track Sale" and "Track Lead" report a conversion against whatever token was
// captured earlier.
//
// The sandbox cannot set attributes on an injected script, which is how the
// pasted snippet is normally configured, so settings go through the
// window.linklyConfig global that linkly.js reads on load.

const injectScript = require('injectScript');
const createArgumentsQueue = require('createArgumentsQueue');
const setInWindow = require('setInWindow');
const copyFromWindow = require('copyFromWindow');
const callInWindow = require('callInWindow');
const makeInteger = require('makeInteger');
const makeString = require('makeString');

const SRC = 'https://cdn.linklyhq.com/linkly.js';

// linkly.js reads its config as strings, because a data-* attribute cannot
// hold anything else. Matching that here keeps one code path in the SDK rather
// than two that could drift.
const flag = (value) => (value === false ? 'false' : 'true');

// Make sure window.linkly is callable before anything calls it. If the tracker
// has already loaded this is a no-op; if it has not — a Track tag firing before
// Initialise, or racing it — the queue holds the call until the file lands and
// drains it. Either way nothing is dropped for want of ordering.
const ensureQueue = () => {
  if (!copyFromWindow('linkly')) {
    createArgumentsQueue('linkly', 'linkly.q');
  }
};

if (data.tagType === 'init') {
  const config = {};

  if (data.cookieDomain) config.cookieDomain = data.cookieDomain;
  if (data.ttlDays) config.ttlDays = makeString(data.ttlDays);
  config.cleanUrl = flag(data.cleanUrl);
  config.ga4 = flag(data.ga4Bridge);
  if (data.ga4Bridge !== false && data.ga4Events) config.ga4Events = data.ga4Events;

  // Written before the script is requested, so it is in place by the time the
  // file parses and reads it.
  setInWindow('linklyConfig', config, true);
  ensureQueue();

  // The URL doubles as the cache token: one artifact, always the same key.
  injectScript(SRC, data.gtmOnSuccess, data.gtmOnFailure, SRC);
} else {
  const isSale = data.tagType === 'sale';
  const eventName = isSale ? data.saleEventName : data.leadEventName;
  const eventId = isSale ? data.eventId : data.leadEventId;

  const options = {};
  options.type = isSale ? 'sale' : 'lead';

  if (isSale && data.amount) options.amount = makeInteger(data.amount);
  if (isSale && data.currency) options.currency = data.currency;
  if (eventId) options.eventId = makeString(eventId);
  if (data.customerId) options.customerId = makeString(data.customerId);

  ensureQueue();
  callInWindow('linkly', 'track', eventName, options);

  data.gtmOnSuccess();
}


___WEB_PERMISSIONS___

[
  {
    "instance": {
      "key": {
        "publicId": "inject_script",
        "versionId": "1"
      },
      "param": [
        {
          "key": "urls",
          "value": {
            "type": 2,
            "listItem": [
              {
                "type": 1,
                "string": "https://cdn.linklyhq.com/linkly.js"
              }
            ]
          }
        }
      ]
    },
    "clientAnnotations": {
      "isEditedByUser": true
    },
    "isRequired": true
  },
  {
    "instance": {
      "key": {
        "publicId": "access_globals",
        "versionId": "1"
      },
      "param": [
        {
          "key": "keys",
          "value": {
            "type": 2,
            "listItem": [
              {
                "type": 3,
                "mapKey": [
                  {
                    "type": 1,
                    "string": "key"
                  },
                  {
                    "type": 1,
                    "string": "read"
                  },
                  {
                    "type": 1,
                    "string": "write"
                  },
                  {
                    "type": 1,
                    "string": "execute"
                  }
                ],
                "mapValue": [
                  {
                    "type": 1,
                    "string": "linkly"
                  },
                  {
                    "type": 8,
                    "boolean": true
                  },
                  {
                    "type": 8,
                    "boolean": true
                  },
                  {
                    "type": 8,
                    "boolean": true
                  }
                ]
              },
              {
                "type": 3,
                "mapKey": [
                  {
                    "type": 1,
                    "string": "key"
                  },
                  {
                    "type": 1,
                    "string": "read"
                  },
                  {
                    "type": 1,
                    "string": "write"
                  },
                  {
                    "type": 1,
                    "string": "execute"
                  }
                ],
                "mapValue": [
                  {
                    "type": 1,
                    "string": "linkly.q"
                  },
                  {
                    "type": 8,
                    "boolean": true
                  },
                  {
                    "type": 8,
                    "boolean": true
                  },
                  {
                    "type": 8,
                    "boolean": false
                  }
                ]
              },
              {
                "type": 3,
                "mapKey": [
                  {
                    "type": 1,
                    "string": "key"
                  },
                  {
                    "type": 1,
                    "string": "read"
                  },
                  {
                    "type": 1,
                    "string": "write"
                  },
                  {
                    "type": 1,
                    "string": "execute"
                  }
                ],
                "mapValue": [
                  {
                    "type": 1,
                    "string": "linklyConfig"
                  },
                  {
                    "type": 8,
                    "boolean": true
                  },
                  {
                    "type": 8,
                    "boolean": true
                  },
                  {
                    "type": 8,
                    "boolean": false
                  }
                ]
              }
            ]
          }
        }
      ]
    },
    "clientAnnotations": {
      "isEditedByUser": true
    },
    "isRequired": true
  }
]


___TESTS___

scenarios:
- name: Initialise injects the tracker
  code: |-
    mock('injectScript', (url, onSuccess) => {
      assertThat(url).isEqualTo('https://cdn.linklyhq.com/linkly.js');
      onSuccess();
    });

    runCode({tagType: 'init', cleanUrl: true, ga4Bridge: true, ttlDays: '90'});

    assertApi('gtmOnSuccess').wasCalled();
- name: Initialise passes the cookie domain through the config global
  code: |-
    let written;
    mock('setInWindow', (key, value) => {
      if (key === 'linklyConfig') written = value;
    });
    mock('injectScript', (url, onSuccess) => onSuccess());

    runCode({tagType: 'init', cookieDomain: '.example.com', cleanUrl: true, ga4Bridge: true});

    assertThat(written.cookieDomain).isEqualTo('.example.com');
- name: Options are stringified the way a data attribute would hold them
  code: |-
    let written;
    mock('setInWindow', (key, value) => {
      if (key === 'linklyConfig') written = value;
    });
    mock('injectScript', (url, onSuccess) => onSuccess());

    runCode({tagType: 'init', cleanUrl: false, ga4Bridge: false});

    assertThat(written.cleanUrl).isEqualTo('false');
    assertThat(written.ga4).isEqualTo('false');
- name: A sale is reported with its amount and order id
  code: |-
    let call;
    mock('copyFromWindow', () => () => {});
    mock('callInWindow', (name, method, eventName, options) => {
      call = {name: name, method: method, eventName: eventName, options: options};
    });

    runCode({
      tagType: 'sale',
      saleEventName: 'purchase',
      amount: '4999',
      currency: 'GBP',
      eventId: 'order-1234'
    });

    assertThat(call.name).isEqualTo('linkly');
    assertThat(call.method).isEqualTo('track');
    assertThat(call.eventName).isEqualTo('purchase');
    assertThat(call.options.type).isEqualTo('sale');
    assertThat(call.options.amount).isEqualTo(4999);
    assertThat(call.options.currency).isEqualTo('GBP');
    assertThat(call.options.eventId).isEqualTo('order-1234');
    assertApi('gtmOnSuccess').wasCalled();
- name: A lead is reported without sale fields
  code: |-
    let call;
    mock('copyFromWindow', () => () => {});
    mock('callInWindow', (name, method, eventName, options) => {
      call = {eventName: eventName, options: options};
    });

    runCode({tagType: 'lead', leadEventName: 'signup', customerId: 'customer-42'});

    assertThat(call.eventName).isEqualTo('signup');
    assertThat(call.options.type).isEqualTo('lead');
    assertThat(call.options.customerId).isEqualTo('customer-42');
    assertThat(call.options.amount).isEqualTo(undefined);
- name: A track tag firing before the tracker loads queues the call
  code: |-
    let queued = false;
    mock('copyFromWindow', () => undefined);
    mock('createArgumentsQueue', () => {
      queued = true;
      return () => {};
    });
    mock('callInWindow', () => {});

    runCode({tagType: 'sale', saleEventName: 'purchase', eventId: 'order-1'});

    assertThat(queued).isEqualTo(true);
    assertApi('gtmOnSuccess').wasCalled();


___NOTES___

Created on 2026-08-26
