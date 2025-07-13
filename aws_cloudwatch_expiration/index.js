let AWS = require("aws-sdk");

const cloudwatchlogs = new AWS.CloudWatchLogs({ region: 'us-east-1' });
const rateLimit = .05

// Get's all log groups from cloudwatch
async function getGroupNames() {
    let nextToken = null;
    let groups = []
    do {
        // const logGroupsResponse = await cloudwatchlogs.describeLogGroups({ limit: 50, logGroupNamePrefix: "/aws/lambda/dev-atom-search-Lambdas", nextToken: nextToken }).promise();
        const logGroupsResponse = await cloudwatchlogs.describeLogGroups({ limit: 50, nextToken: nextToken }).promise();

        // Do something with the retrieved log groups
        groups.push(...logGroupsResponse.logGroups.map(group => group.arn))

        // Get the next token. If there are no more log groups, the token will be undefined
        nextToken = logGroupsResponse.nextToken;
    } while (nextToken);
    return groups
}

function delaySec(time) {
    return new Promise(resolve => {
        setTimeout(resolve, time * 1000);
    });
}

async function setRetentionPolicies(groups, days) {
    for (let i = 0; i < groups.length; i++) {
        let group = groups[i]

        let groupName = group.split(':')[group.split(':').length - 2]
        try {
            await cloudwatchlogs.putRetentionPolicy({
                logGroupName: groupName,
                retentionInDays: days
            }).promise()
        } catch (e) {
            throw new Error(e)
        }

        await delaySec(rateLimit) //Rate limit calls to x seconds wait every request
    }
}

async function main() {
    console.log(`Started fetching groups`)
    let groups = await getGroupNames() //Fetches all groups with prefix /aws/lambda
    console.log(`Fetched all groups :: ${groups.length} total`)

    console.log(`Setting Retention Policies`)
    await setRetentionPolicies(groups, 14) //Assign retention can be 1, 3, 5, 7, 14, 30, 60, 90, 120, 150, 180, 365, 400, 545, 731, 1096, 1827, 2192, 2557, 2922, 3288, and 3653
    console.log(`Finished Setting Retention Policies`)
}

main()