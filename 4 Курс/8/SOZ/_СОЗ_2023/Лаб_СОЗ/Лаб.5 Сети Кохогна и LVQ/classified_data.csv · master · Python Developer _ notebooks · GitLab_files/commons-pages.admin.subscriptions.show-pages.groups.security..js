(this.webpackJsonp=this.webpackJsonp||[]).push([[32],{"99pJ":function(t,e,n){t.exports=n("NFDe")},FxFN:function(t,e,n){"use strict";n.d(e,"h",(function(){return c})),n.d(e,"e",(function(){return l})),n.d(e,"g",(function(){return s})),n.d(e,"i",(function(){return d})),n.d(e,"b",(function(){return f})),n.d(e,"c",(function(){return b})),n.d(e,"a",(function(){return v})),n.d(e,"f",(function(){return p})),n.d(e,"j",(function(){return g})),n.d(e,"d",(function(){return h}));var i=n("P/Kr"),r=n.n(i),o=(n("TPye"),n("FMw2"),n("3UXl"),n("iyoE"),n("99pJ")),a=n.n(o);const c=function(t){return!("string"!=typeof t||!t.startsWith("gid://gitlab/"))},u=function(t){const[e,n]=(""+t).replace(/gid:\/\/gitlab\//g,"").split("/");return{type:e,id:n}},l=function(t=""){const e=c(t)?u(t).id:t,n=parseInt(e,10);return Number.isInteger(n)?n:null},s=function(t=""){if(!c(t))return null;const{type:e}=u(t);return e||null},d={append:"APPEND",remove:"REMOVE",replace:"REPLACE"},f=function(t,e){if("string"!=typeof t)throw new TypeError("type must be a string; got "+typeof t);if(!["number","string"].includes(typeof e))throw new TypeError("id must be a number or string; got "+typeof e);return c(e)?e:`gid://gitlab/${t}/${e}`},b=function(t,e){return e.map((function(e){return f(t,e)}))},v=function(t){if(!r()(t))throw new TypeError("nodes must be an array; got "+typeof t);return t.map((function(t){return t.id?{...t,id:l(t.id)}:t}))},p=function(t,e="nodes"){var n;return null!==(n=null==t?void 0:t[e])&&void 0!==n?n:[]},g=function(t,e=1e4){const n=function(t){a.a.hidden()?t.stopPolling():t.startPolling(e)};n(t),a.a.change(n.bind(null,t))},h=function(t,e=""){return{fetchOptions:{method:"GET"},headers:{"X-GITLAB-GRAPHQL-FEATURE-CORRELATION":t,"X-GITLAB-GRAPHQL-RESOURCE-ETAG":e,"X-Requested-With":"XMLHttpRequest"}}}},LLbv:function(t,e,n){"use strict";n.d(e,"a",(function(){return M}));var i=n("0zRR"),r=n("MtBe"),o=n("h3Ey"),a=n("TjC/"),c=n("8ENL"),u=n("t8l0"),l=n("EGUT"),s=n("qTlp"),d=n("tTwu"),f=n("BrvI"),b=n("NSGy"),v=n("Ddgg"),p=n("7bmO"),g=n("aM4G"),h=n("RhHz");function m(t,e){var n=Object.keys(t);if(Object.getOwnPropertySymbols){var i=Object.getOwnPropertySymbols(t);e&&(i=i.filter((function(e){return Object.getOwnPropertyDescriptor(t,e).enumerable}))),n.push.apply(n,i)}return n}function y(t){for(var e=1;e<arguments.length;e++){var n=null!=arguments[e]?arguments[e]:{};e%2?m(Object(n),!0).forEach((function(e){_(t,e,n[e])})):Object.getOwnPropertyDescriptors?Object.defineProperties(t,Object.getOwnPropertyDescriptors(n)):m(Object(n)).forEach((function(e){Object.defineProperty(t,e,Object.getOwnPropertyDescriptor(n,e))}))}return t}function _(t,e,n){return e in t?Object.defineProperty(t,e,{value:n,enumerable:!0,configurable:!0,writable:!0}):t[e]=n,t}var O="__BV_Tooltip__",j={focus:!0,hover:!0,click:!0,blur:!0,manual:!0},w=/^html$/i,E=/^noninteractive$/i,P=/^nofade$/i,I=/^(auto|top(left|right)?|bottom(left|right)?|left(top|bottom)?|right(top|bottom)?)$/i,T=/^(window|viewport|scrollParent)$/i,k=/^d\d+$/i,L=/^ds\d+$/i,R=/^dh\d+$/i,S=/^o-?\d+$/i,D=/^v-.+$/i,N=/\s+/,$=function(t,e,n){if(r.h){var m=function(t,e){var n={title:void 0,trigger:"",placement:"top",fallbackPlacement:"flip",container:!1,animation:!0,offset:0,id:null,html:!1,interactive:!0,disabled:!1,delay:Object(u.b)(i.lb,"delay",50),boundary:String(Object(u.b)(i.lb,"boundary","scrollParent")),boundaryPadding:Object(v.c)(Object(u.b)(i.lb,"boundaryPadding",5),0),variant:Object(u.b)(i.lb,"variant"),customClass:Object(u.b)(i.lb,"customClass")};if(Object(f.m)(t.value)||Object(f.g)(t.value)||Object(f.e)(t.value)?n.title=t.value:Object(f.j)(t.value)&&(n=y(y({},n),t.value)),Object(f.n)(n.title)){var r=c.d?e.props:(e.data||{}).attrs;n.title=r&&!Object(f.o)(r.title)?r.title:void 0}Object(f.j)(n.delay)||(n.delay={show:Object(v.c)(n.delay,0),hide:Object(v.c)(n.delay,0)}),t.arg&&(n.container="#".concat(t.arg)),Object(p.h)(t.modifiers).forEach((function(t){if(w.test(t))n.html=!0;else if(E.test(t))n.interactive=!1;else if(P.test(t))n.animation=!1;else if(I.test(t))n.placement=t;else if(T.test(t))t="scrollparent"===t?"scrollParent":t,n.boundary=t;else if(k.test(t)){var e=Object(v.c)(t.slice(1),0);n.delay.show=e,n.delay.hide=e}else L.test(t)?n.delay.show=Object(v.c)(t.slice(2),0):R.test(t)?n.delay.hide=Object(v.c)(t.slice(2),0):S.test(t)?n.offset=Object(v.c)(t.slice(1),0):D.test(t)&&(n.variant=t.slice(2)||null)}));var o={};return Object(a.b)(n.trigger||"").filter(s.a).join(" ").trim().toLowerCase().split(N).forEach((function(t){j[t]&&(o[t]=!0)})),Object(p.h)(t.modifiers).forEach((function(t){t=t.toLowerCase(),j[t]&&(o[t]=!0)})),n.trigger=Object(p.h)(o).join(" "),"blur"===n.trigger&&(n.trigger="focus"),n.trigger||(n.trigger="hover focus"),n}(e,n);if(!t[O]){var _=Object(d.a)(n,e);t[O]=Object(g.a)(_,h.a,{_scopeId:Object(l.a)(_,void 0)}),t[O].__bv_prev_data__={},t[O].$on(o.M,(function(){Object(f.e)(m.title)&&t[O].updateData({title:m.title(t)})}))}var $={title:m.title,triggers:m.trigger,placement:m.placement,fallbackPlacement:m.fallbackPlacement,variant:m.variant,customClass:m.customClass,container:m.container,boundary:m.boundary,delay:m.delay,offset:m.offset,noFade:!m.animation,id:m.id,interactive:m.interactive,disabled:m.disabled,html:m.html},M=t[O].__bv_prev_data__;if(t[O].__bv_prev_data__=$,!Object(b.a)($,M)){var A={target:t};Object(p.h)($).forEach((function(e){$[e]!==M[e]&&(A[e]="title"===e&&Object(f.e)($[e])?$[e](t):$[e])})),t[O].updateData(A)}}},M={bind:function(t,e,n){$(t,e,n)},componentUpdated:function(t,e,n){Object(c.e)((function(){$(t,e,n)}))},unbind:function(t){!function(t){t[O]&&(t[O].$destroy(),t[O]=null),delete t[O]}(t)}}},LdIe:function(t,e,n){"use strict";var i=n("ZfjD"),r=n("Tnqw").every;i({target:"AsyncIterator",proto:!0,real:!0},{every:function(t){return r(this,t)}})},NFDe:function(t,e,n){!function(e){"use strict";var i=-1,r=function(t){return t.every=function(e,n,r){t._time(),r||(r=n,n=null);var o=i+=1;return t._timers[o]={visible:e,hidden:n,callback:r},t._run(o,!1),t.isSupported()&&t._listen(),o},t.stop=function(e){return!!t._timers[e]&&(t._stop(e),delete t._timers[e],!0)},t._timers={},t._time=function(){t._timed||(t._timed=!0,t._wasHidden=t.hidden(),t.change((function(){t._stopRun(),t._wasHidden=t.hidden()})))},t._run=function(n,i){var r,o=t._timers[n];if(t.hidden()){if(null===o.hidden)return;r=o.hidden}else r=o.visible;var a=function(){o.last=new Date,o.callback.call(e)};if(i){var c=new Date-o.last;r>c?o.delay=setTimeout((function(){o.id=setInterval(a,r),a()}),r-c):(o.id=setInterval(a,r),a())}else o.id=setInterval(a,r)},t._stop=function(e){var n=t._timers[e];clearInterval(n.id),clearTimeout(n.delay),delete n.id,delete n.delay},t._stopRun=function(e){var n=t.hidden(),i=t._wasHidden;if(n&&!i||!n&&i)for(var r in t._timers)t._stop(r),t._run(r,!n)},t};t.exports?t.exports=r(n("lNHW")):r(e.Visibility)}(window)},PTOk:function(t,e,n){"use strict";var i=n("ZfjD"),r=n("H81m"),o=n("oaN/"),a=n("70tN"),c=n("re4r");i({target:"Iterator",proto:!0,real:!0},{every:function(t){a(this),o(t);var e=c(this),n=0;return!r(e,(function(e,i){if(!t(e,n++))return i()}),{IS_RECORD:!0,INTERRUPTED:!0}).stopped}})},U8h0:function(t,e,n){"use strict";n.d(e,"a",(function(){return l}));n("B++/"),n("z6RN"),n("47t/"),n("LdIe"),n("PTOk"),n("++os"),n("whUo"),n("3UXl"),n("iyoE");var i=n("/lV4");function r({binding:t,vnode:e}){return t.instance?t.instance:e.context}const o={valueMissing:{isInvalid:function(t){var e;return null===(e=t.validity)||void 0===e?void 0:e.valueMissing},message:Object(i.a)("Please fill out this field.")},urlTypeMismatch:{isInvalid:function(t){var e;return"url"===t.type&&(null===(e=t.validity)||void 0===e?void 0:e.typeMismatch)},message:Object(i.a)("Please enter a valid URL format, ex: http://www.example.com/home")}},a=function(t){const{target:e}=t,n=e.querySelector("input:invalid");n&&n.focus()},c=function(t){return t.querySelector("input")||t},u=function(t){return function({el:e,form:n,reportInvalidInput:i=!1}){const{name:r}=e;if(!r)return void 0;const o=n.fields[r],a=e.checkValidity();o.state=i?a:a||null,o.feedback=i?function(t,e){const n=Object.values(t).find((function(t){return t.isInvalid(e)}));let i=null;return n&&(i=e.getAttribute("validation-message")),(null==n?void 0:n.message)||i||e.validationMessage}(t,e):"",n.state=function(t){return Object.values(t.fields).every((function({state:t}){return!0===t}))}(n)}};function l(t={}){const e={...o,...t},n=new WeakMap;return{inserted(t,i,o){const{arg:l}=i,s=c(t),{form:d}=s,f=r({binding:i,vnode:o}),b=u(e),v={validate:b,isTouched:!1,isBlurred:!1};n.set(s,v),s.addEventListener("input",(function t(){v.isTouched=!0,s.removeEventListener("input",t)})),s.addEventListener("blur",(function t({target:e}){v.isTouched&&(v.isBlurred=!0,b({el:e,form:f.form,reportInvalidInput:!0}),s.removeEventListener("blur",t))})),d&&d.addEventListener("submit",a),b({el:s,form:f.form,reportInvalidInput:l})},update(t,e,i){const o=c(t),{arg:a}=e,{validate:u,isTouched:l,isBlurred:s}=n.get(o),d=a||l&&s;u({el:o,form:r({binding:e,vnode:i}).form,reportInvalidInput:d})}}}},lNHW:function(t,e,n){!function(e){"use strict";var n=-1,i={onVisible:function(t){var e=i.isSupported();if(!e||!i.hidden())return t(),e;var n=i.change((function(e,r){i.hidden()||(i.unbind(n),t())}));return n},change:function(t){if(!i.isSupported())return!1;var e=n+=1;return i._callbacks[e]=t,i._listen(),e},unbind:function(t){delete i._callbacks[t]},afterPrerendering:function(t){var e=i.isSupported();if(!e||"prerender"!=i.state())return t(),e;var n=i.change((function(e,r){"prerender"!=r&&(i.unbind(n),t())}));return n},hidden:function(){return!(!i._doc.hidden&&!i._doc.webkitHidden)},state:function(){return i._doc.visibilityState||i._doc.webkitVisibilityState||"visible"},isSupported:function(){return!(!i._doc.visibilityState&&!i._doc.webkitVisibilityState)},_doc:document||{},_callbacks:{},_change:function(t){var e=i.state();for(var n in i._callbacks)i._callbacks[n].call(i._doc,t,e)},_listen:function(){if(!i._init){var t="visibilitychange";i._doc.webkitVisibilityState&&(t="webkit"+t);var e=function(){i._change.apply(i,arguments)};i._doc.addEventListener?i._doc.addEventListener(t,e):i._doc.attachEvent(t,e),i._init=!0}}};t.exports?t.exports=i:e.Visibility=i}(this)},tTwu:function(t,e,n){"use strict";n.d(e,"a",(function(){return r}));var i=n("8ENL"),r=function(t,e){return i.d?e.instance:t.context}}}]);
//# sourceMappingURL=commons-pages.admin.subscriptions.show-pages.groups.security.policies.edit-pages.groups.security.pol-6bfecbfa.b4429696.chunk.js.map