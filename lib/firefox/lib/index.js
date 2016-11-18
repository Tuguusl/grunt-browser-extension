'use strict';

var data = require('sdk/self').data;

var disable = {
    firefox: {{json disable.firefox}}
};

{{#if extend_ff_index}}
{{> extend_ff_index }}
{{/if}}

{{#unless disable.firefox.page_action}}
{{#if page_action}}
require('sdk/ui/button/action').ActionButton({
  {{#if page_action.id}}id: "{{page_action.id}}",{{/if}}
  label: "{{page_action.default_title}}",
  icon: "./{{page_action.default_icon}}",
  onClick: {{#if page_action.callback}}{{page_action.callback}}{{else}}function(state) {
    tabs.open(data.url("{{page_action.default_popup}}"));
  }{{/if}}
});
{{/if}}
{{/unless}}

{{#unless disable.firefox.content_scripts}}
{{#if content_scripts}}
require("sdk/page-mod").PageMod({
    {{#if content_scripts.js}}
    contentScriptFile: [
      {{#each content_scripts.js}}
          data.url("{{this}}"),
      {{/each}}
    ],
    {{/if}}
    {{#if content_scripts.css}}
    contentStyleFile: [
      {{#each content_scripts.css}}
          data.url("{{this}}"),
      {{/each}}
    ],
    {{/if}}
    include: '{{host}}',
    contentScriptWhen: 'ready'
});
{{/if}}
{{/unless}}
