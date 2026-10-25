<%-- WEB-INF/includes/style.jsp — Design system commun LIAS --%>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<style>
@import url('https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600&display=swap');

:root {
  --navy:       #0B1F45;
  --navy-light: #142D60;
  --blue:       #2563EB;
  --blue-hover: #1D4ED8;
  --blue-pale:  #EFF4FF;
  --surface:    #F7F9FC;
  --white:      #FFFFFF;
  --border:     #E4E9F2;
  --text:       #1A1F36;
  --text-muted: #6B7A99;
  --green:      #059669;
  --green-pale: #ECFDF5;
  --amber:      #D97706;
  --amber-pale: #FFFBEB;
  --red:        #DC2626;
  --red-pale:   #FEF2F2;
  --sidebar-w:  260px;
  --radius:     12px;
  --radius-sm:  8px;
}

*, *::before, *::after { margin:0; padding:0; box-sizing:border-box; }
body { font-family:'Inter',Arial,sans-serif; background:var(--surface); color:var(--text); display:flex; min-height:100vh; }

/* ─── SIDEBAR ─── */
.sidebar {
  width: var(--sidebar-w);
  height: 100vh;
  background: var(--navy);
  position: fixed;
  top: 0; 
  left: 0;
  display: flex;
  flex-direction: column;
  padding: 0;
  overflow-y: auto;
  overflow-x: hidden;
  z-index: 100;
}
.sidebar::-webkit-scrollbar{
  width: 6px;
}

.sidebar::-webkit-scrollbar-thumb{
  background: var(--blue);
  border-radius: 10px;
}
.sidebar-top {
  padding: 28px 20px 20px;
  border-bottom: 1px solid rgba(255,255,255,0.08);
}
.logo {
  display: flex;
  align-items: center;
  gap: 10px;
  text-decoration: none;
}
.logo-mark {
  width: 34px; height: 34px;
  background: var(--blue);
  border-radius: 9px;
  display: flex; align-items: center; justify-content: center;
  font-size: 15px; font-weight: 600; color: #fff;
  flex-shrink: 0;
}
.logo-text { font-size: 17px; font-weight: 600; color: #fff; letter-spacing: .3px; }
.logo-sub  { font-size: 10px; color: rgba(255,255,255,0.45); letter-spacing: .5px; text-transform: uppercase; }

.user-badge {
  margin: 16px 20px 0;
  display: flex; align-items: center; gap: 10px;
}
.avatar {
  width: 32px; height: 32px;
  background: var(--blue);
  border-radius: 50%;
  display: flex; align-items: center; justify-content: center;
  font-size: 12px; font-weight: 600; color: #fff; flex-shrink: 0;
}
.user-info .user-name  { font-size: 12px; font-weight: 500; color: #fff; }
.user-info .user-role  { font-size: 11px; color: rgba(255,255,255,0.45); }

.nav { padding: 12px 12px; flex: 1; }
.nav-section {
  font-size: 10px; font-weight: 600; letter-spacing: .8px;
  color: rgba(255,255,255,0.35); text-transform: uppercase;
  padding: 16px 8px 6px;
}
.nav a {
  display: flex; align-items: center; gap: 10px;
  color: rgba(255,255,255,0.65);
  text-decoration: none;
  padding: 9px 10px;
  border-radius: var(--radius-sm);
  font-size: 13.5px;
  transition: background .15s, color .15s;
  margin-bottom: 2px;
}
.nav a:hover { background: rgba(255,255,255,0.07); color: #fff; }
.nav a.active { background: var(--blue); color: #fff; font-weight: 500; }
.nav a .icon { font-size: 16px; width: 20px; text-align: center; flex-shrink: 0; }
.nav a.logout { margin-top: 8px; color: rgba(255,255,255,0.4); }
.nav a.logout:hover { background: rgba(220,38,38,0.15); color: #fca5a5; }

/* ─── MAIN ─── */
.main { margin-left: var(--sidebar-w); flex: 1; padding: 32px 36px; max-width: calc(100vw - var(--sidebar-w)); }

/* ─── PAGE HEADER ─── */
.page-header { margin-bottom: 28px; }
.page-header h1 { font-size: 22px; font-weight: 600; color: var(--text); }
.page-header p  { font-size: 14px; color: var(--text-muted); margin-top: 4px; }
.page-header-row { display: flex; align-items: flex-end; justify-content: space-between; flex-wrap: wrap; gap: 12px; }

/* ─── CARDS ─── */
.card {
  background: var(--white);
  border: 1px solid var(--border);
  border-radius: var(--radius);
  padding: 24px;
}

/* ─── STAT CARDS ─── */
.stats-row { display: grid; grid-template-columns: repeat(auto-fit, minmax(160px,1fr)); gap: 16px; margin-bottom: 28px; }
.stat-card {
  background: var(--white);
  border: 1px solid var(--border);
  border-radius: var(--radius);
  padding: 20px 22px;
}
.stat-card .stat-num  { font-size: 30px; font-weight: 600; color: var(--blue); line-height: 1; }
.stat-card .stat-lbl  { font-size: 12px; color: var(--text-muted); margin-top: 6px; }
.stat-card .stat-icon { font-size: 22px; float: right; margin-top: -2px; }

/* ─── MODULE GRID ─── */
.module-grid { display: grid; grid-template-columns: repeat(3,1fr); gap: 16px; }
.module-card {
  background: var(--white);
  border: 1px solid var(--border);
  border-radius: var(--radius);
  padding: 22px;
  transition: box-shadow .2s, border-color .2s;
}
.module-card:hover { box-shadow: 0 4px 16px rgba(0,0,0,0.08); border-color: #c5d3ee; }
.module-card .mc-icon { font-size: 26px; margin-bottom: 12px; }
.module-card h3 { font-size: 14px; font-weight: 600; color: var(--text); margin-bottom: 6px; }
.module-card p  { font-size: 12.5px; color: var(--text-muted); line-height: 1.5; }
.module-card .mc-footer { display: flex; align-items: center; justify-content: space-between; margin-top: 16px; }
.module-card .mc-status { font-size: 11px; padding: 3px 8px; border-radius: 20px; font-weight: 500; }
.mc-status.ok     { background: var(--green-pale); color: var(--green); }
.mc-status.soon   { background: var(--amber-pale); color: var(--amber); }

/* ─── TABLE ─── */
.table-wrap { overflow-x: auto; }
table { width: 100%; border-collapse: collapse; font-size: 13.5px; }
thead th {
  background: var(--surface);
  color: var(--text-muted);
  font-size: 11px; font-weight: 600; text-transform: uppercase; letter-spacing: .5px;
  padding: 10px 14px;
  text-align: left;
  border-bottom: 1px solid var(--border);
}
tbody td { padding: 13px 14px; border-bottom: 1px solid var(--border); vertical-align: middle; }
tbody tr:last-child td { border-bottom: none; }
tbody tr:hover { background: #FAFBFF; }

/* ─── BADGES ─── */
.badge {
  display: inline-block; padding: 3px 9px; border-radius: 20px;
  font-size: 11px; font-weight: 500;
}
.badge-blue   { background: var(--blue-pale);  color: var(--blue); }
.badge-green  { background: var(--green-pale);  color: var(--green); }
.badge-amber  { background: var(--amber-pale);  color: var(--amber); }
.badge-red    { background: var(--red-pale);    color: var(--red); }
.badge-gray   { background: #F1F3F9; color: var(--text-muted); }

/* ─── BUTTONS ─── */
.btn {
  display: inline-flex; align-items: center; gap: 6px;
  padding: 9px 16px; border-radius: var(--radius-sm);
  font-size: 13px; font-weight: 500;
  cursor: pointer; text-decoration: none; border: none; transition: .15s;
}
.btn-primary { background: var(--blue); color: #fff; }
.btn-primary:hover { background: var(--blue-hover); }
.btn-ghost { background: transparent; color: var(--text-muted); border: 1px solid var(--border); }
.btn-ghost:hover { background: var(--surface); color: var(--text); }
.btn-danger { background: var(--red-pale); color: var(--red); }
.btn-danger:hover { background: #fee2e2; }
.btn-sm { padding: 5px 10px; font-size: 12px; }

/* ─── FORM ─── */
.form-grid { display: grid; grid-template-columns: 1fr 1fr; gap: 0 20px; }
.form-full { grid-column: 1 / -1; }
.form-group { margin-bottom: 18px; }
.form-group label { display: block; font-size: 12.5px; font-weight: 500; color: var(--text); margin-bottom: 6px; }
.form-group input,
.form-group select,
.form-group textarea {
  width: 100%; padding: 9px 12px;
  border: 1px solid var(--border); border-radius: var(--radius-sm);
  font-size: 13.5px; font-family: inherit; color: var(--text);
  background: #fff; transition: border-color .15s;
}
.form-group input:focus,
.form-group select:focus,
.form-group textarea:focus { outline: none; border-color: var(--blue); }
.form-group textarea { resize: vertical; min-height: 90px; }

/* ─── EMPTY STATE ─── */
.empty-state { text-align: center; padding: 60px 20px; }
.empty-state .es-icon { font-size: 40px; margin-bottom: 12px; }
.empty-state h3 { font-size: 15px; font-weight: 600; margin-bottom: 6px; }
.empty-state p  { font-size: 13px; color: var(--text-muted); }

/* ─── ACTIONS BAR ─── */
.actions-bar { display: flex; align-items: center; justify-content: space-between; margin-bottom: 20px; flex-wrap: wrap; gap: 10px; }
.search-box {
  display: flex; align-items: center; gap: 8px;
  border: 1px solid var(--border); border-radius: var(--radius-sm);
  padding: 7px 12px; background: #fff; min-width: 220px;
}
.search-box input { border: none; outline: none; font-size: 13px; font-family: inherit; width: 100%; }

/* ─── ALERT ─── */
.alert { padding: 12px 16px; border-radius: var(--radius-sm); font-size: 13px; margin-bottom: 18px; }
.alert-success { background: var(--green-pale); color: var(--green); border: 1px solid #a7f3d0; }
.alert-error   { background: var(--red-pale); color: var(--red); border: 1px solid #fecaca; }
/* ─── DASHBOARD MODERNE ─── */

.dashboard-hero{
  background: linear-gradient(135deg, var(--navy), var(--blue));
  color:white;
  border-radius: 24px;
  padding: 32px;
  margin-bottom: 28px;
  box-shadow: 0 16px 35px rgba(37,99,235,0.25);
}

.dashboard-hero h1{
  font-size: 30px;
  color:white;
  margin-bottom:8px;
}

.dashboard-hero p{
  color:rgba(255,255,255,0.8);
  font-size:15px;
}

.module-card{
  border:none;
  border-radius:22px;
  padding:26px;
  box-shadow:0 12px 30px rgba(0,0,0,0.07);
}

.module-card:hover{
  transform:translateY(-6px);
  box-shadow:0 18px 40px rgba(0,0,0,0.12);
}

.module-card .mc-icon{
  width:58px;
  height:58px;
  border-radius:18px;
  background:var(--blue-pale);
  display:flex;
  align-items:center;
  justify-content:center;
  font-size:28px;
}

.module-card h3{
  font-size:18px;
  color:var(--navy);
  margin-top:14px;
}

.module-card p{
  font-size:13px;
  line-height:1.7;
}

.stat-card{
  border:none;
  border-radius:20px;
  box-shadow:0 10px 25px rgba(0,0,0,0.06);
}
</style>
