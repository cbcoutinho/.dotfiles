import de.heikoseeberger.sbtfresh.FreshPlugin.autoImport._
import de.heikoseeberger.sbtfresh.license.License // Only needed for `freshLicense` setting

freshOrganization     := "com.example"        // Organization – "default" by default
freshAuthor           := "Chris Coutinho"        // Author – value of "user.name" system property or "default" by default
freshLicense          := None // Optional license – `apache20` by default
freshSetUpGit         := true             // Initialize a Git repo and create an initial commit – `true` by default
freshSetUpTravis      := false              // Configure Travis for Continuous Integration - `false` by default
freshSetUpWartremover := false              // Include the sbt wartremover (http://www.wartremover.org) plugin - `false` by default
