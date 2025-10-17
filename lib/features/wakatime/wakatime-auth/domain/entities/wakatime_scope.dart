enum WakaTimeScope {
  readSummaries('read_summaries'),
  readSummariesCategories('read_summaries.categories'),
  readSummariesDependencies('read_summaries.dependencies'),
  readSummariesEditors('read_summaries.editors'),
  readSummariesLanguages('read_summaries.languages'),
  readSummariesMachines('read_summaries.machines'),
  readSummariesOperatingSystems('read_summaries.operating_systems'),
  readSummariesProjects('read_summaries.projects'),
  readStats('read_stats'),
  readStatsBestDay('read_stats.best_day'),
  readStatsCategories('read_stats.categories'),
  readStatsDependencies('read_stats.dependencies'),
  readStatsEditors('read_stats.editors'),
  readStatsLanguages('read_stats.languages'),
  readStatsMachines('read_stats.machines'),
  readStatsOperatingSystems('read_stats.operating_systems'),
  readStatsProjects('read_stats.projects'),
  readGoals('read_goals'),
  readOrgs('read_orgs'),
  writeOrgs('write_orgs'),
  readPrivateLeaderboards('read_private_leaderboards'),
  writePrivateLeaderboards('write_private_leaderboards'),
  readHeartbeats('read_heartbeats'),
  writeHeartbeats('write_heartbeats'),
  email('email');

  final String value;
  const WakaTimeScope(this.value);
}
