# Human-held devices Dataset.

We construct a human-held devices WiFi localization dataset, consisting of approximately 90k data points collected from ten volunteers across four classic indoor scenarios. We believe this dataset provides a more practical view for the future research on WiFi-based localization. 

*Note: This is a beta version of the dataset for review. 
We will continue to update and improve the relevant description of the dataset. 
This dataset will be made publicly available upon acceptance of this work.

## Dataset Introduction

For more detailed information, please refer to the paper section: Dataset.

## Dataset Structure

The format of each .mat filename is "RoomName_APName_VolunteerID_InterferenceState".
For example, the filename "Lounge_sRE4_user1_w" denotes that this data is collected in the Lounge, using AP sRE4, with the target user ID 1, while there is simultaneous interference from another persons;
The filename "Lab_sRE5_user5_w" denotes that this data is collected in the Laboratory, using AP sRE5, with the target user ID 5, while there is no interference from another persons. 