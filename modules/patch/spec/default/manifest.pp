node default {

  $patch = 'diff --git a/bar b/bar
index 54d55bf..bb50d03 100644
--- a/bar
+++ b/bar
@@ -1,3 +1,4 @@
 one
 two
-three
\ No newline at end of file
+three
+four and five
diff --git a/foo b/foo
index fa58e34..5526998 100644
--- a/foo
+++ b/foo
@@ -1,3 +1,4 @@
 line one
 line two
-line three
\ No newline at end of file
+line two and a half
+line three'

  file {'/tmp/foo':
    content => "line one\nline two\nline three",
  }
  ->

  file {'/tmp/bar':
    content => "one\ntwo\nthree",
  }
  ->

  patch {'/tmp':
    content => $patch,
  }
}
