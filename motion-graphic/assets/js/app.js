/* =========================================================
   گهرترابر — موتور موشن‌گرافی
   ========================================================= */
(() => {
  'use strict';

  const $ = (s, r = document) => r.querySelector(s);
  const $$ = (s, r = document) => Array.from(r.querySelectorAll(s));
  const FA = '۰۱۲۳۴۵۶۷۸۹';
  const fa = (n) => String(n).replace(/\d/g, (d) => FA[+d]);
  const pad2 = (n) => (n < 10 ? '0' + n : String(n));
  const mmss = (s) => {
    s = Math.max(0, Math.round(s || 0));
    return fa(pad2(Math.floor(s / 60)) + ':' + pad2(s % 60));
  };

  /* ---------------- icons ---------------- */
  const I = {
    truck: '<path d="M2.5 7.5h10.5v9H2.5z"/><path d="M13 10.5h3.6l3 3v3H13z"/><circle cx="6.2" cy="18" r="1.7"/><circle cx="17" cy="18" r="1.7"/>',
    fog: '<path d="M5 11a4.4 4.4 0 0 1 8.4-1.7A3.7 3.7 0 0 1 19 12.3"/><path d="M3 15.4h18M5.5 18.8h13"/>',
    mic: '<rect x="9.2" y="3" width="5.6" height="10.4" rx="2.8"/><path d="M5.6 11.8a6.4 6.4 0 0 0 12.8 0"/><path d="M12 18.2V21"/>',
    star: '<path d="m12 3 2.6 5.6 6.1.8-4.5 4.2 1.2 6-5.4-3-5.4 3 1.2-6L3.3 9.4l6.1-.8z"/>',
    chart: '<path d="M4 20V11M10 20V4M16 20v-6M21 20H2.8"/>',
    alert: '<path d="M12 3.4 2.6 20.2h18.8z"/><path d="M12 9.4v4.6"/><circle cx="12" cy="17.1" r=".9"/>',
    shield: '<path d="M12 2.6 4.6 6v6c0 4.4 3.1 7.6 7.4 9.4 4.3-1.8 7.4-5 7.4-9.4V6z"/><path d="m8.9 12.1 2.3 2.4 4.2-4.6"/>',
    clock: '<circle cx="12" cy="12" r="8.6"/><path d="M12 7.4V12l3.2 2"/>',
    swap: '<path d="M4 8.4h13.4l-3.2-3.2"/><path d="M20 15.6H6.6l3.2 3.2"/>',
    compass: '<circle cx="12" cy="12" r="8.6"/><path d="m15.6 8.4-2.1 5.1-5.1 2.1 2.1-5.1z"/>',
    file: '<path d="M6.4 3h7.2L18 7.4V21H6.4z"/><path d="M13.4 3v4.8H18"/><path d="M9.2 13h5.6M9.2 16.8h3.6"/>',
    check: '<path d="m5 12.4 4.6 4.6L19 7"/>',
    x: '<path d="m6.4 6.4 11.2 11.2M17.6 6.4 6.4 17.6"/>',
    route: '<circle cx="6" cy="6" r="2.4"/><circle cx="18" cy="18" r="2.4"/><path d="M8.4 6h5.4a3.4 3.4 0 0 1 0 6.8h-3.6a3.4 3.4 0 0 0 0 6.8h5.4"/>',
    flag: '<path d="M5.2 21V3.8"/><path d="M5.2 4.6h12.4l-2.2 4.2 2.2 4.2H5.2"/>',
    hierarchy: '<rect x="9" y="2.6" width="6" height="5" rx="1.4"/><rect x="2.6" y="16.4" width="6" height="5" rx="1.4"/><rect x="15.4" y="16.4" width="6" height="5" rx="1.4"/><path d="M12 7.6v4.2M5.6 16.4v-2.2h12.8v2.2"/>',
    users: '<circle cx="9.2" cy="8.4" r="3.2"/><path d="M3.6 20c0-3 2.5-5 5.6-5s5.6 2 5.6 5"/><path d="M16 5.6a3 3 0 0 1 0 5.8"/><path d="M17.6 15.5c2 .6 3.3 2.3 3.3 4.5"/>',
    spark: '<path d="M12 3.2l1.7 5.1 5.1 1.7-5.1 1.7-1.7 5.1-1.7-5.1L5.2 10l5.1-1.7z"/>',
    seedling: '<path d="M12 21v-7.4"/><path d="M12 13.6C12 9.9 9.4 7.2 5.4 7c-.2 4 2.3 6.6 6.6 6.6z"/><path d="M12 13.6c0-3.2 2.2-5.6 5.6-5.8.2 3.4-2 5.8-5.6 5.8z"/>',
    hourglass: '<path d="M7 3.4h10M7 20.6h10"/><path d="M7.8 3.4c0 4.2 8.4 5.2 8.4 8.6s-8.4 4.4-8.4 8.6"/><path d="M16.2 3.4c0 4.2-8.4 5.2-8.4 8.6s8.4 4.4 8.4 8.6"/>',
    fuel: '<path d="M4.5 21V4.6a1.6 1.6 0 0 1 1.6-1.6h5.4a1.6 1.6 0 0 1 1.6 1.6V21"/><path d="M3.4 21h11.6"/><path d="M13.1 8.4h3.2a1.8 1.8 0 0 1 1.8 1.8v6.2a1.6 1.6 0 0 0 3.2 0V9.6l-2-2.6"/><path d="M7 9.4h3.6"/>'
  };
  const svg = (name, cls = '') =>
    `<svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="1.6" stroke-linecap="round" stroke-linejoin="round"${cls ? ` class="${cls}"` : ''} aria-hidden="true">${I[name] || I.spark}</svg>`;

  /* ---------------- elements ---------------- */
  const app = $('#app');
  const stage = $('#stage');
  const scenesEl = $('#scenes');
  const progressEl = $('#progress');
  const captionEl = $('#caption');
  const cNow = $('#cNow');
  const cAll = $('#cAll');
  const dock = $('#dock');
  const btnPlay = $('#btnPlay');
  const btnSound = $('#btnSound');
  const btnFull = $('#btnFull');
  const btnStart = $('#btnStart');
  const veil = $('#veil');
  const timeline = $('#timeline');
  const tlFill = $('#tlFill');
  const tlHead = $('#tlHead');
  const timeEl = $('#time');
  const stageTap = $('#stageTap');
  const particlesEl = $('#particles');

  /* ---------------- state ---------------- */
  let DATA = null;
  let SCENE_DATA = [];
  let scenes = [];       // DOM elements
  let blocks = [];       // per scene: [{el, beat}]
  let beats = [];        // per scene: [{el, beat, time}]
  let audios = [];       // per scene: HTMLAudioElement|null
  let durations = [];    // per scene seconds
  let beatTimes = [];    // per scene array of start times
  let idx = -1;
  let playing = false;
  let started = false;
  let muted = false;
  let currentSceneStart = 0;
  let virtualT = 0;
  let lastFrame = 0;
  let shownBeat = -1;
  let ambience = null;
  let hideTimer = null;
  let totalDuration = 0;
  let finished = false;

  const CHARS_PER_SEC = 13.2;

  /* ---------------- build ---------------- */
  function esc(s) {
    return String(s).replace(/[&<>"]/g, (c) => ({ '&': '&amp;', '<': '&lt;', '>': '&gt;', '"': '&quot;' }[c]));
  }

  function buildTitle(scene) {
    const accents = (scene.accent || []).join(' ').split(/\s+/).filter(Boolean)
      .map((w) => w.replace(/[،.:؛«»"']/g, ''));
    const words = String(scene.title || '').split(/\s+/).filter(Boolean);
    let i = 0;
    return words.map((w) => {
      const bare = w.replace(/[،.:؛«»"']/g, '');
      const isAccent = accents.includes(bare);
      const inner = isAccent ? `<em>${esc(w)}</em>` : esc(w);
      const delay = 120 + i * 78;
      i++;
      return `<span class="w"><span class="wi" style="--wd:${delay}ms">${inner}</span></span>`;
    }).join(' ');
  }

  function blockHTML(b, bi) {
    const d = (bi * 90);
    switch (b.type) {
      case 'lead':
        return `<p class="lead b" data-beat="${b.beat}" style="--d:${d}ms">${esc(b.text)}</p>`;

      case 'card':
        return `<div class="card b" data-tone="${b.tone || 'info'}" data-beat="${b.beat}" style="--d:${d}ms">
            <span class="c-ico">${svg(b.icon || 'spark')}</span>
            <span class="c-txt"><span class="c-title">${esc(b.title)}</span><span class="c-sub">${esc(b.sub)}</span></span>
          </div>`;

      case 'checklist':
        return `<ul class="checklist b" data-beat="${b.beat}" style="--d:${d}ms">
            ${b.items.map((t, i) => `<li data-beat="${b.beat}" style="--td:${140 + i * 130}ms">
              <span class="tick">${svg('check')}</span><span>${esc(t)}</span></li>`).join('')}
          </ul>`;

      case 'ladder':
        return `<div class="ladder b" data-beat="${b.beat}" style="--d:${d}ms">
            ${b.items.map((t, i) => `<div class="rung" data-beat="${b.beat}" style="--td:${120 + i * 150}ms">
              <span class="r-num">${fa(i + 1)}</span><span class="r-txt">${esc(t)}</span></div>`).join('')}
          </div>`;

      case 'chips':
        return `<div class="chips b" data-beat="${b.beat}" style="--d:${d}ms">
            ${b.items.map((t, i) => `<span class="chip" data-beat="${b.beat}" style="--td:${120 + i * 130}ms">
              <span class="dot"></span>${esc(t)}</span>`).join('')}
          </div>`;

      case 'badge':
        return `<div class="badge b" data-beat="${b.beat}" style="--d:${d}ms">${svg(b.icon || 'clock')}<span>${esc(b.text)}</span></div>`;

      case 'note':
        return `<div class="note b" data-beat="${b.beat}" style="--d:${d}ms">${svg(b.icon || 'alert')}<span>${esc(b.text)}</span></div>`;

      case 'people':
        return `<div class="people b" data-beat="${b.beat}" style="--d:${d}ms">
            ${b.items.map((p, i) => `<div class="person" data-beat="${b.beat}" style="--td:${120 + i * 150}ms">
              <div class="p-badge">${esc(p.label)}</div>
              <div class="p-name">${esc(p.name)}</div>
              <div class="p-role">سرشیفت</div></div>`).join('')}
          </div>`;

      case 'quote':
        return `<div class="quote b" data-beat="${b.beat}" style="--d:${d}ms">
            <span class="q-mark">”</span><span class="q-txt">${esc(b.text)}</span></div>`;

      default:
        return '';
    }
  }

  function buildScene(scene, i) {
    const sec = document.createElement('section');
    sec.className = 'scene';
    sec.dataset.layout = scene.layout || 'stack';
    sec.dataset.id = scene.id;

    let html = `<div class="scene-body">
      <div class="kicker" data-beat="0"><span class="k-dot"></span><span>${esc(scene.kicker || '')}</span><span class="k-line"></span></div>
      <h1 class="title">${buildTitle(scene)}</h1>`;

    if (scene.layout === 'stack') html += '<div class="stack">';
    (scene.blocks || []).forEach((b, bi) => { html += blockHTML(b, bi); });
    if (scene.layout === 'stack') html += '</div>';

    if (scene.layout === 'outro') {
      html += `<div class="lockup b" data-beat="${(scene.beats || []).length - 1}" style="--d:220ms">
        <span class="lk-line"></span><span class="lk-name">گهرترابر</span>
        <span class="lk-sub">چرخه حمل‌ونقل داخلی · شک نکنید</span></div>`;
    }

    html += '</div>';
    sec.innerHTML = html;
    return sec;
  }

  function buildProgress(n) {
    progressEl.innerHTML = '';
    for (let i = 0; i < n; i++) {
      const s = document.createElement('div');
      s.className = 'seg';
      s.dataset.i = i;
      s.setAttribute('role', 'tab');
      s.setAttribute('aria-label', 'فصل ' + fa(i + 1));
      s.innerHTML = '<i></i>';
      s.addEventListener('click', (e) => { e.stopPropagation(); goScene(i); });
      progressEl.appendChild(s);
    }
  }

  function fallbackDuration(scene) {
    const chars = (scene.beats || []).reduce((a, b) => a + (b.narration || '').length, 0);
    return Math.max(6, chars / CHARS_PER_SEC + 0.9);
  }

  function computeBeatTimes(i) {
    const scene = SCENE_DATA[i];
    const bs = scene.beats || [];
    const d = durations[i] || fallbackDuration(scene);
    const chars = bs.map((b) => Math.max(8, (b.narration || '').length));
    const total = chars.reduce((a, b) => a + b, 0) || 1;
    let acc = 0;
    const times = [];
    bs.forEach((b, k) => {
      // small breathing room at the very start of the scene
      const lead = k === 0 ? 0.12 : 0;
      times.push(lead + (acc / total) * d);
      acc += chars[k];
    });
    beatTimes[i] = times;
  }

  function refreshTotal() {
    totalDuration = durations.reduce((a, b) => a + b, 0);
    updateTime();
  }

  function updateHint() {
    const el = document.querySelector('.veil-hint');
    if (!el || !totalDuration) return;
    const mins = Math.max(1, Math.round(totalDuration / 60));
    el.textContent = 'برای شنیدن روایت، صدا را روشن کنید · حدود ' + fa(mins) + ' دقیقه';
  }

  function seedParticles(n = 16) {
    if (!particlesEl) return;
    let html = '';
    for (let i = 0; i < n; i++) {
      const left = Math.round(Math.random() * 100);
      const bottom = Math.round(Math.random() * 88);
      const dur = (16 + Math.random() * 18).toFixed(1);
      const delay = (Math.random() * 18).toFixed(1);
      const dx = Math.round((Math.random() * 2 - 1) * 46);
      const size = (2 + Math.random() * 2.4).toFixed(1);
      html += `<i style="left:${left}%;bottom:${bottom}%;width:${size}px;height:${size}px;--dx:${dx}px;animation-duration:${dur}s;animation-delay:-${delay}s"></i>`;
    }
    particlesEl.innerHTML = html;
  }

  /* ---------------- audio ---------------- */
  function initAudio() {
    const amb = DATA.meta && DATA.meta.audio && DATA.meta.audio.ambience;
    if (amb) {
      ambience = new Audio(amb);
      ambience.loop = true;
      ambience.volume = 0;
      ambience.preload = 'auto';
    }
    SCENE_DATA.forEach((s, i) => {
      if (!s.audio) { audios[i] = null; durations[i] = fallbackDuration(s); return; }
      const a = new Audio();
      a.preload = 'auto';
      a.src = s.audio;
      a.addEventListener('loadedmetadata', () => {
        if (isFinite(a.duration) && a.duration > 0.4) {
          durations[i] = a.duration;
          computeBeatTimes(i);
          refreshTotal();
          updateHint();
          if (i === idx) updateCounterAndBar();
        }
      });
      a.addEventListener('error', () => { audios[i] = null; durations[i] = fallbackDuration(s); computeBeatTimes(i); refreshTotal(); });
      a.addEventListener('ended', () => { if (i === idx) nextScene(); });
      audios[i] = a;
      durations[i] = fallbackDuration(s);
      computeBeatTimes(i);
    });
    refreshTotal();
  }

  /* ---------------- playback ---------------- */
  function clearReveals(i) {
    $$('.in', scenes[i]).forEach((el) => el.classList.remove('in'));
  }

  function revealBeat(i, k) {
    const nodes = $$(`[data-beat="${k}"]`, scenes[i]);
    nodes.forEach((el) => el.classList.add('in'));
  }

  function setCaption(text) {
    if (!text) return;
    if (captionEl.textContent === text) return;
    captionEl.classList.add('is-swap');
    setTimeout(() => {
      captionEl.textContent = text;
      captionEl.classList.remove('is-swap');
    }, 180);
  }

  function updateCounterAndBar() {
    cNow.textContent = fa(pad2(idx + 1));
    $$('.seg', progressEl).forEach((s, k) => {
      s.classList.toggle('is-done', k < idx);
      s.classList.toggle('is-current', k === idx);
      const fill = s.querySelector('i');
      if (k === idx) {
        const d = durations[idx] || 1;
        fill.style.transform = 'scaleX(' + Math.min(1, Math.max(0, virtualT / d)) + ')';
      } else if (k > idx) {
        fill.style.transform = 'scaleX(0)';
      }
    });
  }

  function updateTime() {
    let before = 0;
    for (let k = 0; k < idx; k++) before += durations[k] || 0;
    const t = before + Math.max(0, virtualT);
    timeEl.textContent = mmss(t) + ' / ' + mmss(totalDuration);
    const p = totalDuration ? Math.min(1, t / totalDuration) : 0;
    tlFill.style.transform = 'scaleX(' + p + ')';
    tlHead.style.right = (p * 100) + '%';
    timeline.setAttribute('aria-valuenow', String(Math.round(p * 100)));
  }

  function playScene(i, opts = {}) {
    finished = false;
    if (i < 0) i = 0;
    if (i >= SCENE_DATA.length) { endOfShow(); return; }
    const prev = idx;
    idx = i;
    virtualT = 0;
    shownBeat = -1;

    scenes.forEach((el, k) => {
      el.classList.toggle('is-active', k === i);
      el.classList.toggle('is-past', k < i);
      if (k !== i) el.classList.remove('is-active');
    });

    // stop previous audio
    if (prev >= 0 && prev !== i && audios[prev]) { try { audios[prev].pause(); audios[prev].currentTime = 0; } catch (e) {} }
    clearReveals(i);

    const a = audios[i];
    if (a && !opts.silent) {
      try { a.currentTime = 0; } catch (e) {}
      a.muted = muted;
      const pr = a.play();
      if (pr && pr.catch) pr.catch(() => { playing = false; syncUI(); });
    }

    if (ambience && started) { ambience.volume = muted ? 0 : 0.085; const pr = ambience.play(); if (pr && pr.catch) pr.catch(() => {}); }

    currentSceneStart = performance.now();
    lastFrame = currentSceneStart;
    playing = true;
    app.classList.add('is-playing');
    updateCounterAndBar();
    updateTime();
    armDockHide();

    if (started) {
      const b0 = (SCENE_DATA[i].beats && SCENE_DATA[i].beats[0]) || null;
      setCaption(b0 ? b0.caption : '');
    }
    if (opts.revealFirst) { revealBeat(i, andraBeat(i)); }
  }

  // first beat index of the scene
  function andraBeat(i) {
    const bs = SCENE_DATA[i].beats || [];
    return bs.length ? 0 : 0;
  }

  function pauseAll() {
    playing = false;
    app.classList.remove('is-playing');
    if (idx >= 0 && audios[idx]) { try { audios[idx].pause(); } catch (e) {} }
    if (ambience) { try { ambience.pause(); } catch (e) {} }
    syncUI();
    showDock();
    disarmDockHide();
  }

  function resume() {
    if (idx < 0) { playScene(0); return; }
    playing = true;
    app.classList.add('is-playing');
    const a = audios[idx];
    if (a) {
      a.muted = muted;
      const pr = a.play();
      if (pr && pr.catch) pr.catch(() => {});
    }
    if (ambience) { ambience.volume = muted ? 0 : 0.085; const pr = ambience.play(); if (pr && pr.catch) pr.catch(() => {}); }
    lastFrame = performance.now();
    syncUI();
    armDockHide();
  }

  function togglePlay() {
    if (!started) { begin(); return; }
    if (finished) { finished = false; veil.dataset.mode = 'hidden'; playScene(0); return; }
    if (playing) pauseAll(); else resume();
  }

  function nextScene() {
    if (idx + 1 >= SCENE_DATA.length) { endOfShow(); return; }
    playScene(idx + 1);
  }

  function prevScene() {
    if (idx <= 0) { playScene(0); return; }
    playScene(idx - 1);
  }

  function goScene(i) {
    if (!started) { begin(i); return; }
    playScene(Math.max(0, Math.min(SCENE_DATA.length - 1, i)));
  }

  function seekGlobal(ratio) {
    const target = Math.max(0, Math.min(1, ratio)) * totalDuration;
    let acc = 0, i = 0;
    for (; i < durations.length; i++) {
      if (target < acc + durations[i]) break;
      acc += durations[i];
    }
    if (i >= durations.length) { i = durations.length - 1; acc = totalDuration - durations[i]; }
    const offset = Math.max(0, target - acc);
    if (!started) { begin(i); return; }
    if (i !== idx) playScene(i);
    if (audios[i]) { try { audios[i].currentTime = offset; } catch (e) {} }
    virtualT = offset;
    // re-reveal accordingly
    const bt = beatTimes[i] || [];
    $$('[data-beat]', scenes[i]).forEach((el) => {
      const b = +el.dataset.beat;
      el.classList.toggle('in', bt[b] !== undefined && offset >= bt[b]);
      if (el.classList.contains('kicker')) el.classList.toggle('in', true);
    });
    shownBeat = -1;
    lastFrame = performance.now();
  }

  function endOfShow() {
    finished = true;
    playing = false;
    app.classList.remove('is-playing');
    if (ambience) { try { ambience.pause(); } catch (e) {} }
    if (idx >= 0 && audios[idx]) { try { audios[idx].pause(); } catch (e) {} }
    syncUI();
    showEndVeil();
    showDock();
    disarmDockHide();
  }

  /* ---------------- clock ---------------- */
  function frame(now) {
    requestAnimationFrame(frame);
    const dt = Math.min(0.12, (now - lastFrame) / 1000);
    lastFrame = now;
    if (!playing || idx < 0) return;

    const a = audios[idx];
    if (a && !a.paused && !a.ended) {
      virtualT = a.currentTime;
    } else {
      virtualT += dt;
    }

    const d = durations[idx] || 1;
    const bt = beatTimes[idx] || [];
    const scene = SCENE_DATA[idx];

    const ANTICIPATE = 0.9; // visuals land slightly before the spoken line
    for (let k = 0; k < bt.length; k++) {
      if (virtualT + (k === 0 ? 0.02 : ANTICIPATE) >= bt[k] && shownBeat < k) {
        shownBeat = k;
        revealBeat(idx, k);
        const b = scene.beats[k];
        if (b && b.caption) setCaption(b.caption);
      }
    }
    if (bt.length) {
      // kicker / title are tied to scene start
      const kk = scenes[idx].querySelector('.kicker');
      if (kk && !kk.classList.contains('in')) kk.classList.add('in');
    }

    updateCounterAndBar();
    updateTime();

    if (!a && virtualT >= d) nextScene();
  }
  requestAnimationFrame(frame);

  /* ---------------- UI ---------------- */
  function syncUI() {
    btnPlay.setAttribute('aria-label', playing ? 'توقف' : 'پخش');
  }

  function armDockHide() {
    disarmDockHide();
    if (!playing) return;
    hideTimer = setTimeout(() => { if (playing) showDock(false); }, 2800);
  }
  function disarmDockHide() { if (hideTimer) { clearTimeout(hideTimer); hideTimer = null; } }
  function showDock(v = true) {
    dock.dataset.visible = v ? 'true' : 'false';
    if (v) armDockHide();
  }

  function showEndVeil() {
    veil.dataset.mode = 'end';
    veil.querySelector('.veil-kicker').textContent = 'گهرترابر · حمل‌ونقل داخلی';
    veil.querySelector('.veil-title').innerHTML = 'پایان پیام<br /><span style="color:var(--gold)">همدلی، همت، تلاشگری</span>';
    veil.querySelector('.veil-sub').textContent = 'با هم، چرخ حمل‌ونقل را پرتوان‌تر می‌چرخانیم';
    btnStart.querySelector('span').textContent = 'پخش دوباره';
    veil.classList.remove('pause-note');
  }

  function unlockAudio() {
    audios.forEach((a) => {
      if (!a) return;
      try {
        a.muted = true;
        const pr = a.play();
        if (pr && pr.then) pr.then(() => { try { a.pause(); } catch (e) {} }).catch(() => {});
        try { a.pause(); } catch (e) {}
        a.muted = muted;
        try { a.currentTime = 0; } catch (e) {}
      } catch (e) {}
    });
    if (ambience) {
      try { ambience.volume = 0; const pr = ambience.play(); if (pr && pr.catch) pr.catch(() => {}); } catch (e) {}
    }
  }

  function begin(atIndex) {
    unlockAudio();
    started = true;
    veil.dataset.mode = 'hidden';
    if (muted) { muted = false; app.classList.remove('is-muted'); }
    playScene(typeof atIndex === 'number' ? atIndex : 0);
    syncUI();
  }

  /* ---------------- fit ---------------- */
  function fit() {
    const vw = window.innerWidth, vh = window.innerHeight;
    const isDesktop = vw >= 900 && vh >= 620 && (vh / vw) < 1.35 && vw > 780;
    app.classList.toggle('is-desktop', isDesktop);
    app.classList.toggle('is-mobile', !isDesktop);
    let s, h;
    if (isDesktop) {
      s = Math.min((vw - 90) / 1080, (vh - 190) / 1920);
      h = 1920;
    } else {
      // portrait: fill the screen edge to edge and let the canvas grow taller
      const byWidth = vw / 1080, byHeight = vh / 1920;
      if (byWidth <= byHeight) { s = byWidth; h = vh / s; }
      else { s = byHeight; h = 1920; }
    }
    document.documentElement.style.setProperty('--s', String(s));
    stage.style.height = h + 'px';
  }
  window.addEventListener('resize', fit, { passive: true });
  window.addEventListener('orientationchange', () => setTimeout(fit, 120));

  /* ---------------- events ---------------- */
  btnPlay.addEventListener('click', (e) => { e.stopPropagation(); togglePlay(); });
  btnStart.addEventListener('click', (e) => { e.stopPropagation(); if (started && !playing && veil.dataset.mode === 'end') { veil.dataset.mode = 'hidden'; playScene(0); } else begin(); });
  btnSound.addEventListener('click', () => {
    muted = !muted;
    app.classList.toggle('is-muted', muted);
    if (audios[idx]) audios[idx].muted = muted;
    if (ambience) ambience.volume = muted ? 0 : 0.085;
    if (muted) { showDock(); }
  });
  btnFull.addEventListener('click', () => {
    if (!document.fullscreenElement) {
      (document.documentElement.requestFullscreen || (() => {})).call(document.documentElement);
    } else { document.exitFullscreen && document.exitFullscreen(); }
  });
  stageTap.addEventListener('click', () => {
    if (!started) { begin(); return; }
    togglePlay();
    showDock();
  });

  // seeking on the timeline
  let scrubbing = false;
  const ratioFromEvent = (clientX) => {
    const r = timeline.getBoundingClientRect();
    // RTL: right edge is the start
    return 1 - (clientX - r.left) / r.width;
  };
  const startScrub = (e) => {
    scrubbing = true;
    seekGlobal(ratioFromEvent(e.clientX !== undefined ? e.clientX : e.touches[0].clientX));
  };
  const moveScrub = (e) => {
    if (!scrubbing) return;
    const x = e.clientX !== undefined ? e.clientX : (e.touches && e.touches[0] ? e.touches[0].clientX : null);
    if (x == null) return;
    seekGlobal(ratioFromEvent(x));
  };
  const endScrub = () => { scrubbing = false; };
  timeline.addEventListener('pointerdown', startScrub);
  window.addEventListener('pointermove', moveScrub);
  window.addEventListener('pointerup', endScrub);
  timeline.addEventListener('keydown', (e) => {
    const cur = totalDuration ? (() => { let b = 0; for (let k = 0; k < idx; k++) b += durations[k]; return (b + virtualT) / totalDuration; })() : 0;
    if (e.key === 'ArrowLeft') { seekGlobal(cur + 0.02); e.preventDefault(); }
    if (e.key === 'ArrowRight') { seekGlobal(cur - 0.02); e.preventDefault(); }
  });

  document.addEventListener('keydown', (e) => {
    if (e.key === ' ' || e.code === 'Space') { e.preventDefault(); togglePlay(); }
    else if (e.key === 'ArrowLeft') { prevScene(); }
    else if (e.key === 'ArrowRight') { nextScene(); }
    else if (e.key.toLowerCase() === 'm') { btnSound.click(); }
    else if (e.key.toLowerCase() === 'f') { btnFull.click(); }
    else if (e.key.toLowerCase() === 'r') { playScene(0); }
  });

  window.addEventListener('pointermove', () => { if (playing) showDock(); }, { passive: true });
  window.addEventListener('touchstart', () => { if (playing) showDock(); }, { passive: true });
  document.addEventListener('visibilitychange', () => { if (document.hidden && playing) pauseAll(); });

  /* ---------------- boot ---------------- */
  async function boot() {
    fit();
    try {
      const res = await fetch('assets/data/scenes.json', { cache: 'no-cache' });
      DATA = await res.json();
    } catch (err) {
      // graceful fallback for file:// usage
      scenesEl.innerHTML = '<p style="padding:40px;font-size:28px;line-height:2;color:#f2778c">برای اجرا، پروژه را از طریق یک وب‌سرور محلی باز کنید.<br>مثال: <span dir="ltr">python3 -m http.server</span></p>';
      return;
    }
    SCENE_DATA = DATA.scenes;
    cAll.textContent = fa(pad2(SCENE_DATA.length));
    buildProgress(SCENE_DATA.length);

    SCENE_DATA.forEach((s, i) => {
      const el = buildScene(s, i);
      scenes.push(el);
      scenesEl.appendChild(el);
    });

    seedParticles();
    initAudio();
    updateHint();
    // warm up first scene title/kicker state
    idx = -1;
    playScenePassive();
    syncUI();
    setTimeout(fit, 60);
    if (document.fonts && document.fonts.ready) document.fonts.ready.then(fit);

    // deep-link / QA helper:  index.html?scene=3  |  ?scene=3&hold=1
    const qp = new URLSearchParams(location.search);
    const sParam = qp.get('scene');
    if (sParam) {
      const target = Math.max(0, Math.min(SCENE_DATA.length - 1, parseInt(sParam, 10) - 1 || 0));
      started = true;
      veil.dataset.mode = 'hidden';
      playScene(target, { silent: qp.get('hold') === '1' });
      if (qp.get('hold') === '1') {
        playing = false;
        app.classList.remove('is-playing');
        [...Array(SCENE_DATA[target].beats.length).keys()].forEach((k) => revealBeat(target, k));
      }
    }
  }

  window.__mg = {
    go: (n) => playScene(Math.max(0, Math.min(SCENE_DATA.length - 1, n))),
    revealAll: (n) => [...Array(SCENE_DATA[n].beats.length).keys()].forEach((k) => revealBeat(n, k)),
    pause: () => pauseAll(),
    state: () => ({ idx, playing, durations, beatTimes, totalDuration })
  };

  // show scene 1 in a "paused/preview" state under the veil
  function playScenePassive() {
    idx = 0;
    scenes.forEach((el, k) => {
      el.classList.toggle('is-active', k === 0);
      el.classList.toggle('is-past', false);
    });
    const d = durations[0] || 8;
    virtualT = 0;
    updateCounterAndBar();
    const b0 = SCENE_DATA[0].beats && SCENE_DATA[0].beats[0];
    if (b0) captionEl.textContent = b0.caption;
    // reveal kicker+title, hold blocks until play
    const kick = scenes[0].querySelector('.kicker');
    if (kick) setTimeout(() => kick.classList.add('in'), 500);
  }

  boot();
})();
