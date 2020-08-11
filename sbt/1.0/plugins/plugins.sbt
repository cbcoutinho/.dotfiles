addSbtPlugin("com.timushev.sbt"         % "sbt-updates"           % "0.5.1")
addSbtPlugin("org.scalameta"            % "sbt-scalafmt"          % "2.4.0")
addSbtPlugin("de.heikoseeberger"        % "sbt-fresh"             % "5.8.4")
addSbtPlugin("org.scalastyle"          %% "scalastyle-sbt-plugin" % "1.0.0")
addSbtPlugin("org.foundweekends.giter8" % "sbt-giter8"            % "0.12.0")
addSbtPlugin("org.foundweekends.giter8" % "sbt-giter8-scaffold"   % "0.12.0")

// This isn't available for sbt versions less than 1.3.x: https://github.com/sbt/sbt/issues/5049
//addSbtPlugin("com.lightbend.sbt" % "sbt-java-formatter"    % "0.5.1")

//addSbtPlugin("ch.epfl.scala"     % "sbt-scalafix"          % "0.9.19")

/**
  * Generate eclipse project file(s) for java/scala interop
  * https://github.com/scalameta/metals-feature-requests/issues/5#issuecomment-632771776
  */
addSbtPlugin("com.typesafe.sbteclipse" % "sbteclipse-plugin" % "5.2.4")
