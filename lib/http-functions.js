// this is from WIX backend
// no function in this codebase, just for reference

import { ok, badRequest } from 'wix-http-functions';
import { triggeredEmails } from 'wix-crm-backend';

export async function post_submitReferralForm(request) {

    try {
        // .json() supposed to return a promise?
        const data = await request.body.json();
        
        //destructure fields
        const {
            patientName,
            patientPhone,
            patientEmail,
            referringDoctorName,
            referringDoctorPhone,
            referringDoctorEmail,
            consultType,
            comments
        } = data;

        // Optional: basic validation
        if (!patientName || !patientPhone || !patientEmail || !referringDoctorName  || !referringDoctorPhone  || !referringDoctorEmail  || !consultType) {
          //status code 400 (is in the root as status:400)
          return badRequest({
            body: {
                error: "The request is missing data",
            },
            headers: {
                "Content-Type": "application/json",
            },
        });
        }

        //do fill out form logic here
        //send email
        //ME MY CONTACT ID: 439d9a1c-6b52-481b-8f9e-2539d75ecd5a
        //info@parkavenueoralsurgery.com: 1d7c5e29-148f-4e46-b71a-0229f17e5330
        await triggeredEmails.emailMember("ReferralFormTriggeredEmail", "439d9a1c-6b52-481b-8f9e-2539d75ecd5a", {
            variables: {
                patientName: patientName,
                patientPhone: patientPhone,
                patientEmail: patientEmail,
                referringDoctorName: referringDoctorName,
                referringDoctorPhone: referringDoctorPhone,
                referringDoctorEmail: referringDoctorEmail,
                consultType: consultType,
                comments: comments,
                // SITE_URL: <enter-value-here>
            }
        });
        //

        //status code 200
        return ok({
            body: {
                key1: "value1",
                key2: "value2",
            },
            headers: {
                "Content-Type": "application/json",
            },
        });
    } catch (err) { 
        return badRequest({
            body: {
                error: "err",
            },
            headers: {
                "Content-Type": "application/json",
            },
        });
    }
}