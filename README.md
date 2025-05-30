<div id="toc" align="center">
  <ul style="list-style: none">
    <summary>
      <h1> hyperpastel's Home Manager Configuration </h1>
    </summary>
  </ul>
</div>

> [!CAUTION] 
> These are my personal files, tuned specifically for my own hardware and workflow.
> This setup **won't work** on your machine without modification. 

This repository houses my Home-Manager configuration. It is [flake](https://nixos.wiki/wiki/Flakes)-based and uses Home Manager as [standalone](https://nix-community.github.io/home-manager/index.xhtml#sec-flakes-standalone).

## 🧱 Structure

### ❄️ home.nix

This file contains the bulk of the configuration and is intended as the entry point. Within is basic information home manager needs for 
it's management, as well as several simple configurations for various programs.

### 📁 modules

This folder contains more elaborate configurations for various software I use. Each file name corresponds to the application being configured in that file.
