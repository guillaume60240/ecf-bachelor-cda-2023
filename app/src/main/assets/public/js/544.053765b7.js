"use strict";(self["webpackChunktest_project"]=self["webpackChunktest_project"]||[]).push([[544],{2642:(e,t,s)=>{s.r(t),s.d(t,{startFocusVisible:()=>c});
/*!
 * (C) Ionic http://ionicframework.com - MIT License
 */
const o="ion-focused",n="ion-focusable",r=["Tab","ArrowDown","Space","Escape"," ","Shift","Enter","ArrowLeft","ArrowRight","ArrowUp","Home","End"],c=e=>{let t=[],s=!0;const c=e?e.shadowRoot:document,i=e||document.body,d=e=>{t.forEach((e=>e.classList.remove(o))),e.forEach((e=>e.classList.add(o))),t=e},a=()=>{s=!1,d([])},u=e=>{s=r.includes(e.key),s||d([])},v=e=>{if(s&&void 0!==e.composedPath){const t=e.composedPath().filter((e=>!!e.classList&&e.classList.contains(n)));d(t)}},E=()=>{c.activeElement===i&&d([])};c.addEventListener("keydown",u),c.addEventListener("focusin",v),c.addEventListener("focusout",E),c.addEventListener("touchstart",a),c.addEventListener("mousedown",a);const L=()=>{c.removeEventListener("keydown",u),c.removeEventListener("focusin",v),c.removeEventListener("focusout",E),c.removeEventListener("touchstart",a),c.removeEventListener("mousedown",a)};return{destroy:L,setFocus:d}}}}]);
//# sourceMappingURL=544.053765b7.js.map