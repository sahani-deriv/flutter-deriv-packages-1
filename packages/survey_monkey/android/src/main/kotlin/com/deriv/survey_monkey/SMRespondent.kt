package com.deriv.survey_monkey

import com.google.gson.annotations.SerializedName

data class SMRespondent(
        @SerializedName("respondent_id") val respondentId: String,
        @SerializedName("completion_status") val completionStatus: String,
        @SerializedName("error") val error: String?,
)
