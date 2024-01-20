select Distinct P.* from facebook_posts P
Inner join facebook_reactions R
on P.post_id = R.post_id
where R.reaction = 'heart';