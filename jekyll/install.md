---
layout: default
title: Download
css_class: install
---

<h1 class="text-centered page-title main-heading">Install Nim</h1>

<div class="slim content">
  <div class="pure-g center os-pickers">
    <div class="pure-u pure-u-md-1-3">
      <a href="{{ site.baseurl }}/install_windows.html">
        <div class="os-picker-box center">
          <i class="fab fa-windows" aria-hidden="true"></i>
        </div>
        <h2>Windows</h2>
      </a>
    </div>

    <div class="pure-u pure-u-md-1-3">
      <a href="{{ site.baseurl }}/install_unix.html">
        <div class="os-picker-box center">
          <i class="fab fa-apple" aria-hidden="true"></i>
          <i class="fab fa-linux" aria-hidden="true"></i>
        </div>
        <h2>Unix</h2>
      </a>
    </div>
  </div>
</div>

<section class="background-faded call-to-action">
  <section class="content text-centered center-banner">
    <h1 class="section-heading">
      <i class="far fa-moon fa-2x" aria-hidden="true"></i>
      Want a nightly build?
    </h1>
    <div class="pure-g center">
      <div class="pure-u-1-2">
        <p>
          We offer nightly builds both for the cutting-edge devel branch and
          for backports to our stable branch.
        </p>
      </div>
      <div class="pure-u-1 center">
        <a class="pure-button" href="https://github.com/nim-lang/nightlies/releases">Get nightlies</a>
      </div>
    </div>
  </section>
</section>


<h1 class="text-centered page-title main-heading">Install previous versions</h1>

<div class="content">
  <table class="pure-table pure-table-horizontal pure-table-striped releases-table" style="width: 100%;">
    <thead>
      <tr>
        <th>Version</th>
        <th>Windows</th>
        <th>Linux</th>
        <th>macOS</th>
        <th>Source</th>
      </tr>
    </thead>
    <tbody>
      {% for release in site.data.nim_releases %}
      {% assign version = release[0] %}
      {% assign assets = release[1] %}
      <tr>
        <td><strong>{{ version }}</strong></td>
        <td>
          {% if assets.windows_x64 %}<a href="{{ assets.windows_x64.github_url }}">x86_64</a> <a href="{{ assets.windows_x64.github_url }}.sha256" class="sha-link">sha</a><br>{% endif %}
          {% if assets.windows_x32 %}<a href="{{ assets.windows_x32.github_url }}">x86</a> <a href="{{ assets.windows_x32.github_url }}.sha256" class="sha-link">sha</a>{% endif %}
        </td>
        <td>
          {% if assets.linux_x64 %}<a href="{{ assets.linux_x64.github_url }}">x86_64</a> <a href="{{ assets.linux_x64.github_url }}.sha256" class="sha-link">sha</a><br>{% endif %}
          {% if assets.linux_x32 %}<a href="{{ assets.linux_x32.github_url }}">x86</a> <a href="{{ assets.linux_x32.github_url }}.sha256" class="sha-link">sha</a><br>{% endif %}
          {% if assets.linux_arm64 %}<a href="{{ assets.linux_arm64.github_url }}">ARM64</a> <a href="{{ assets.linux_arm64.github_url }}.sha256" class="sha-link">sha</a><br>{% endif %}
          {% if assets.linux_armv7l %}<a href="{{ assets.linux_armv7l.github_url }}">ARMv7</a> <a href="{{ assets.linux_armv7l.github_url }}.sha256" class="sha-link">sha</a>{% endif %}
        </td>
        <td>
          {% if assets.macosx_arm64 %}<a href="{{ assets.macosx_arm64.github_url }}">ARM64</a> <a href="{{ assets.macosx_arm64.github_url }}.sha256" class="sha-link">sha</a><br>{% endif %}
          {% if assets.macosx_x64 %}<a href="{{ assets.macosx_x64.github_url }}">x86_64</a> <a href="{{ assets.macosx_x64.github_url }}.sha256" class="sha-link">sha</a>{% endif %}
        </td>
        <td>
          {% if assets.source_tar %}<a href="{{ assets.source_tar.github_url }}">tar.xz</a> <a href="{{ assets.source_tar.github_url }}.sha256" class="sha-link">sha</a>{% endif %}
        </td>
      </tr>
      {% endfor %}
    </tbody>
  </table>
</div>
