// Year
document.getElementById('year').textContent = new Date().getFullYear();

// Theme toggle (stores preference)
const btn = document.getElementById('themeToggle');
const prefersDark = window.matchMedia('(prefers-color-scheme: dark)').matches;
const saved = localStorage.getItem('theme');

function setTheme(mode){
  if(mode === 'light'){
    document.documentElement.style.setProperty('--bg', '#f6f7fb');
    document.documentElement.style.setProperty('--muted', '#ffffff');
    document.documentElement.style.setProperty('--card', '#ffffff');
    document.documentElement.style.setProperty('--text', '#0b0f14');
    document.documentElement.style.setProperty('--sub', '#4b5563');
    document.documentElement.style.setProperty('--border', '#e5e7eb');
    btn.textContent = '🌙';
  } else {
    document.documentElement.style.setProperty('--bg', '#0b0f14');
    document.documentElement.style.setProperty('--muted', '#121821');
    document.documentElement.style.setProperty('--card', '#0f141b');
    document.documentElement.style.setProperty('--text', '#e6edf3');
    document.documentElement.style.setProperty('--sub', '#9fb0c3');
    document.documentElement.style.setProperty('--border', '#1f2937');
    btn.textContent = '🌞';
  }
  localStorage.setItem('theme', mode);
}

setTheme(saved || (prefersDark ? 'dark' : 'light'));

btn.addEventListener('click', () => {
  const current = localStorage.getItem('theme') || (prefersDark ? 'dark' : 'light');
  setTheme(current === 'dark' ? 'light' : 'dark');
});
