## Summary

A bunch of people asked how they could use this script with pure Chromium on Ubuntu. The following is a quick guide. Though I still suggest you at least try Vivaldi. Who knows, you might like it. Worried about proprietary componants? Remember that libwidevinecdm.so is a binary blob you are taking from Chrome, so by following this guide you will have already made your distro less "pure". Also all our additions to the Chromium base are open source and our UI, while not open, is written in HTML/CSS/JS. Thus you can see exactly what we are doing (no funny business). 

If you still want to run Chromium, the following explains how it is done.

## Chromium setup

* Install the package "chromium-codecs-ffmpeg-extra" to provide H.264/MP4 support (used by videos on Netflix). After install, you need to restart Chromium. You can confirm that it is installed and working correctly by going to http://www.quirksmode.org/html5/tests/video.html and checking that the first video listed plays.

* Next run the script (`latest-widevine.sh`). This will create the file "libwidevinecdm.so" in "/opt/google/chrome".
* Replace the "libwidevinecdm.so" provided by Chromium with a symlink to the file from Chrome:

```
sudo ln -fs /opt/google/chrome/libwidevinecdm.so /usr/lib/chromium-browser/libwidevinecdm.so 
```

**Note:** The path is typically "/usr/lib64/chromium/lib/libwidevinecdm.so" on non Debian/Ubuntu based distros.

You can confirm that DRM'd H.264/MP4 content is now playable by going to http://demo.castlabs.com/ and trying some of the demos.

### Damn you Netflix!

The final complication is that Netflix does not expect pure Chromium to be able to be able play videos and hence they do a stupid thing. If they detect that Chromium is accesing a video, they point you to install Silverlight! This is particularly dumb because: you are running Linux (no Silverlight); Silverlight is an NPAPI plugin and Chrom(e|ium) only supports PPAPI. You will need to work around this.

* Delete any cookies or data associated with Netflix. If you have failed to play videos once, then Netflix stores information about this in a cookie and you won't be able to play vidoes, even once your system is now correctly configured. Another "WTF‽" moment from the Netflix team.

* Via a user agent editing extention or by starting Chromium with the `-user-agent` switch, remove the reference to "Ubuntu Chromium/*XX*.0.*XXXX*.*XX*", e.g. 

```
/usr/lib/chromium-browser/chromium-browser --user-agent='Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/51.0.2704.79 Safari/537.36'
```

**Note:** An extenstion is best otherwise you will need to start Chromium from the command line every time or edit the .desktop file to include this switch. 

One final point. Every time Chromium upgrades it will replace the libwidevinecdm.so symlink with its own file. Thus you will need to remove it and re-create the symlink. I would also suggest re-running `latest-widevine.sh` at that point, to check for new versions and upgrade if needed.
