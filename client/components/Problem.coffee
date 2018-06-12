React = require('react')

import SubmitList from './SubmitList'

problemId = (props) ->
    props.material._id.substring(1)

export default Problem = (props) ->
    href = "https://informatics.mccme.ru/moodle/mod/statements/view3.php?chapterid=" + problemId(props)
    <div>
        <div dangerouslySetInnerHTML={{__html: props.material.content}}>
        </div>
        <p><a href={href}>Задача на informatics</a></p>
        {`<SubmitList {...props}/>`}
    </div>
