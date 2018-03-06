package jp.co.jpmd.oiy.dmolbiz.controllers.job

import java.util.Map;

import org.quartz.CronTrigger
import org.quartz.JobDetail
import org.quartz.Scheduler
import org.quartz.Trigger

import jp.co.jpmd.oiy.dmolbiz.services.common.JobService
import jp.co.reso.oiy.core.controllers.AbstractOrderItYourselfController;
import jp.co.jpmd.oiy.dmolbiz.job.*

class JobManagerController extends AbstractOrderItYourselfController {
	
    Scheduler quartzScheduler
    def jobManagerService
    def jobService
    
    def index = {
		redirect(action: list, params: [:])
    }
    
    def list = {
		def jobsList = jobManagerService.getAllJobs();
		def jobsListPlus = [];
		jobsList.each { job ->
			def jobPlus = [:];
			jobPlus.group = job.group;
			jobPlus.name = job.name;
			jobPlus.triggerName = job.triggerName;
			jobPlus.triggerGroup = job.triggerGroup;
			switch (job.status) {
				case Trigger.STATE_NORMAL:
					jobPlus.status = "NORMAL";
					break;
				case Trigger.STATE_PAUSED:
					jobPlus.status = "PAUSED";
					break;
				case Trigger.STATE_COMPLETE:
					jobPlus.status = "COMPLETE";
					break;
				case Trigger.STATE_ERROR:
					jobPlus.status = "ERROR";
					break;
				case Trigger.STATE_BLOCKED:
					jobPlus.status = "BLOCKED";
					break;
				case Trigger.STATE_NONE:
					jobPlus.status = "";
					break;
				default:
					jobPlus.status = "";
					break;
			}
			def trigger = quartzScheduler.getTrigger(job.triggerName, job.triggerGroup);
			jobPlus.nextFireTime = trigger?.getNextFireTime();
			jobsListPlus << jobPlus; 
		}
		
        ["jobsList":jobsListPlus]
		
    }

	def pause = {
        if (params.what?.equals("JOB")) {
            quartzScheduler.pauseJob (params.jobName, params.jobGroup)
        } else if (params.what?.equals("TRIGGER")) {
            quartzScheduler.pauseTrigger (params.triggerName, params.triggerGroup)
        }
        redirect(action: list, params: [:])
    }

    def resume = {
        if (params.what?.equals("JOB")) {
            quartzScheduler.resumeJob (params.jobName, params.jobGroup)
        } else if (params.what?.equals("TRIGGER")) {
            println "Resuming Trigger: ${params.triggerName}-${params.triggerGroup}"
            quartzScheduler.resumeTrigger (params.triggerName, params.triggerGroup)
        }
        redirect(action: list, params: [:])
    }

	def run = {
		def job = grailsApplication.classLoader.loadClass(params.jobName);
		job.triggerNow();
        redirect(action: list, params: [:])
    }
}
