<div class="copyright" >
  {% set current = date(Date.now(), "YYYY") %}
  &copy; {% if theme.since and theme.since != current %} {{ theme.since }} - {% endif %}
  <span itemprop="copyrightYear">{{ current }}</span>
  <span class="with-love">
    <i class="icon-next-heart fa fa-heart"></i>
  </span>
  <span class="author" itemprop="copyrightHolder">{{ config.author }}

  &nbsp;&nbsp;|&nbsp;&nbsp;
  <script type="text/javascript">
    var cnzz_protocol = (("https:" == document.location.protocol) ? " https://" : " http://");
    document.write('站长统计'' type='text/javascript'%3E%3C/script%3E"));
  </script>

  &nbsp;&nbsp;|&nbsp;&nbsp;<span><a href="/sitemap.xml">Google网站地图</a></span>
  &nbsp;&nbsp;|&nbsp;&nbsp;<span><a href="/baidusitemap.xml">百度网站地图</a></span>

  </span>
</div>

<div class="powered-by">
  {{ __('footer.powered', '<a class="theme-link" href="http://hexo.io">Hexo</a>') }}
</div>

<div class="theme-info">
  {{ __('footer.theme') }} -
  <a class="theme-link" href="https://github.com/iissnan/hexo-theme-next">
    NexT{% if theme.scheme %}.{{ theme.scheme }}{% endif %}
  </a>
</div>


&nbsp;&nbsp;|&nbsp;&nbsp;本站总点击 <span id="busuanzi_value_site_pv"></span> 次
&nbsp;&nbsp;|&nbsp;&nbsp;您是第 <span id="busuanzi_value_site_uv"></span> 位访客

<script async src="https://dn-lbstatics.qbox.me/busuanzi/2.3/busuanzi.pure.mini.js">
</script>

<script>
(function(){
    var bp = document.createElement('script');
    bp.src = '//push.zhanzhang.baidu.com/push.js';
    var s = document.getElementsByTagName("script")[0];
    s.parentNode.insertBefore(bp, s);
})();
</script>

{% block footer %}{% endblock %}