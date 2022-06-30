---
title: Understanding the Voting Process
layout: cm_layout
description: An example of the voting process applied to to array-based alerts that are used for the purpose of autoscaling. (i.e. Launching additional instances in a server array.) in RightScale.
---

## Overview

The voting process only applies to array-based alerts that are used for the purpose of autoscaling. (i.e. Launching additional instances in a server array.) The best way to fully understand how the voting process works is to simply walk through an example.

## Example

Voting Tags are used to denote whether or not a Server is voting for a scaling action. RightScale monitors these tags across all voting instances and counts them to determine whether or not enough Servers are voting for a particular scaling action. Let's assume you have a server array with the following alert parameters.

* Nickname: MyArray
* Decision Threshold: 51%
* Choose voters by tag (Voter Tag): [x] default to nickname (e.g. MyArray)
* Resize Up by: 2
* Resize Down by: 1
* Resize Calm Time: 15 (minutes)

RightScale monitors all tags across all of your Servers. For autoscaling purposes RightScale looks for all Servers with the specified Voting Tag that you've assigned to a server array in order to determine when the array should grow/shrink. You can only have one Voting Tag per Server Array.

**Note**: Voting tags are NOT case sensitive.

Let's assume that you've also configured the alert specifications for the voting Servers to use a matching voting tag (e.g. MyArray). It's important that any Server that you want to allow to vote for a scaling action in the server array has a matching voting tag, otherwise RightScale will be looking for an incorrect tag for autoscaling purposes. In this example, each instance that gets launched into the server array is assigned the following tag:

`rs_vote:MyArray=none`

At this point, no Server is voting for a scaling action because their Voting Tags are set to 'none'.

![cm-voting-tags-0votes.png](/img/cm-voting-tags-0votes.png)

Later, an alert is triggered on a Server for a scale-up action. The Server's Voting Tag automatically changes to `rs_vote:MyArray=grow`

![cm-voting-tages-1vote.png](/img/cm-voting-tags-1vote.png)

Because only one Server is voting to scale-up and grow, nothing happens.

However, once another Server also votes to grow, the Server Array's Decision Threshold is exceeded (51%), causing a scaling action to grow the array.

![cm-voting-tags-2votes.png](/img/cm-voting-tags-2votes.png)

In this example, we're going to launch two additional instances into the array (Resize Up by = 2).

![cm-voting-tages-2votes-scaleup.png](/img/cm-voting-tags-2votes-scaleup.png)

Once a scaling action occurs, the Server Array is not allowed to undergo another scaling action until the Resize Calm Time (e.g. 15 min) expires, which is necessary so that the newly launched Servers have enough time to become operational and start making an impact on the array (by offloading some of the work from the overworked instances). Hopefully, the additional Servers can make a significant enough impact so that the triggered alerts disappear and the Voting Tags return to 'none' again.

![cm-voting-tags-after-scaleup.png](/img/cm-voting-tags-after-scaleup.png)

In this example, the extra Servers helped satisfy a spike in traffic. However, once that spike is over and those extra Servers are no longer needed, the array will scale down to save costs. Once again, as soon as the Decision Threshold has been surpassed (e.g. 51% of the Servers are voting to "shrink"), the Server Array automatically scales down by terminating one of your array servers.

![cm-voting-tags-3votes-scaledown.png](/img/cm-voting-tags-3votes-scaledown.png)

Since you typically want to scale down more conservatively than when you scale up, we've configured the Server Array to scale down by one at a time. (e.g. Resize Down by = 1) .

![cm-voting-tags-during-scaledown.png](/img/cm-voting-tags-during-scaledown.png)

In this example, the Server Array only needed to scale down once in order for all of the autoscaling alerts to disappear.

![cm-voting-tags-after-scaledown.png](/img/cm-voting-tags-after-scaledown.png)

## Things to Consider

* A Server can only have one vote; it cannot have a vote to grow and a vote to shrink.
* Only a single Voting Tag (e.g. MyArray) can be assigned to a Server Array. RightScale will look for all Servers that have a particular Voting Tag when evaluating when to autoscale (i.e. grow/shrink the array).
* Votes are aggregated at the Server level, so if a Server has multiple alerts that are using the same Voting Tag (e.g. MyArray), the Server will only have a single aggregated vote. For example, you might have an application that's both memory and cpu intensive, so you create an alert specification that scales based on 'memory' and another alert specification that scales based on 'cpu'. In such cases, there could be a situation where both alerts are triggered on a single Server. Perhaps the 'memory' alert triggers a scale up (grow) action while the 'cpu' alert triggers a scale down (shrink) action. In such cases, the votes would cancel each other out and a Server's Voting Tag would be set to 'none' and no vote would be made for either scaling action. (1grow - 1shrink = none)

![cm-voting-scenarios-none.png](/img/cm-voting-scenarios-none.png)

Similarly, if there are 3 alerts that are being monitored for autoscaling purposes and there are 2 votes to 'grow' and 1 vote to 'shrink', the Server would vote to 'grow' (2grow - 1shrink = grow).  

![cm-voting-scenarios-grow.png](/img/cm-voting-scenarios-grow.png)

* Votes are based upon the Server Array's Voting Tag ("Choose voters by"). RightScale does not check to see which triggered alert caused the Voting Tag to change for a grow/shrink scaling action. So if there are 5 Servers voting to grow based on a triggered 'cpu' alert and another 5 Servers that are voting to grow based on a triggered 'memory' alert, the total number of votes to grow the array is 10. Generally speaking, the important thing to monitor is whether or not a Server needs help regardless of the reason.
* Voting Tags must match. Therefore, the voting tag that you configure when creating the Server Array ("Choose voters by tag") must match the voting tag that is specified when defining an alert specification. Therefore, if you keep the default Voting Tag ("Default to nickname") when creating a Server Array and then create an alert specification, be sure to select the matching Voting Tag. See [Set up Autoscaling using Voting Tags](/cm/dashboard/manage/arrays/arrays_actions.html#set-up-autoscaling-using-voting-tags) for detailed instructions.

![cm-voting-tag-match.png](/img/cm-voting-tag-match.png)
