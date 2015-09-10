使用有意义的 _id  在golang里面需要这样：
type test struct {
    Id int `json:"id" bson:"_id"`
}
